clc;
clear;

filename = 'gravity_line_data.xlsx';
data = readtable(filename);
x = data{:,1};
gravity_anomaly = data{:,2};

% 插值和平滑处理
x_interp = linspace(min(x), max(x), 10*length(x)); % 插值点个数可以调整
gravity_anomaly_interp = interp1(x, gravity_anomaly, x_interp, 'spline'); % 插值
gravity_anomaly_smooth = smooth(gravity_anomaly_interp, 0.1, 'loess'); % 平滑处理

% 设置反演参数
max_iterations = 100; % 最大迭代次数
tolerance = 1e-6; % 收敛容差
grid_size_x = 1; % 横向网格大小，以米为单位
grid_size_z = 0.1; % 纵向网格大小，以米为单位
depth = 2; % 最大深度，以米为单位
depth_levels = ceil(depth / grid_size_z); % 计算纵向网格数量

% 网格化x轴
x_min = min(x_interp);
x_max = max(x_interp);
x_grid = x_min:grid_size_x:x_max;

% 反演
density_model = inverse_gravity_anomaly(x_interp, gravity_anomaly_smooth, x_grid, max_iterations, tolerance, grid_size_x, grid_size_z, depth_levels);

% 绘制反演结果
figure;
imagesc(x_grid, (0:depth_levels-1)*grid_size_z, density_model);
colormap('jet');
colorbar_handle = colorbar;
xlabel('测线位置 (米)');
ylabel('深度 (米)');
title('地下密度反演结果');
ylabel(colorbar_handle, '密度 (g/cc)'); % 设置色标单位
set(gca, 'YDir', 'reverse'); % 反转y轴，使深度从上到下

% 反演函数
function density_model = inverse_gravity_anomaly(x, gravity_anomaly, x_grid, max_iterations, tolerance, grid_size_x, grid_size_z, depth_levels)
    % 初始化密度模型
    density_model = zeros(depth_levels, length(x_grid));
    previous_model = density_model;
    
    for iter = 1:max_iterations
        % 计算正演重力异常
        forward_gravity = forward_gravity_anomaly(x, density_model, x_grid, grid_size_x, grid_size_z, depth_levels);
        residual = gravity_anomaly - forward_gravity; % 计算残差     
        % 更新密度模型
        density_model = density_model + update_density_model(residual, x, x_grid, grid_size_x, grid_size_z, depth_levels);
       
        if max(abs(density_model(:) - previous_model(:))) < tolerance % 检查收敛性
            disp(['反演在第' num2str(iter) '次迭代后收敛']);
            break;
        end
        previous_model = density_model;
    end
end

% 正演重力异常计算函数
function forward_gravity = forward_gravity_anomaly(x, density_model, x_grid, grid_size_x, grid_size_z, depth_levels)
    forward_gravity = zeros(size(x));
    G = 6.67430e-11; % 引力常数
    for i = 1:length(x)
        for j = 1:length(x_grid)
            for k = 1:depth_levels
                r = sqrt((x(i) - x_grid(j))^2 + (k * grid_size_z)^2); % 计算每个网格单元的重力异常
                if r ~= 0
                    forward_gravity(i) = forward_gravity(i) + G * density_model(k, j) * grid_size_x * grid_size_z / r^3;
                end
            end
        end
    end
end

% 更新密度模型函数
function updated_density = update_density_model(residual, x, x_grid, grid_size_x, grid_size_z, depth_levels)
    updated_density = zeros(depth_levels, length(x_grid));
    alpha = 0.1; % 更新步长
    for i = 1:length(residual)
        for j = 1:length(x_grid)
            for k = 1:depth_levels
                r = sqrt((x(i) - x_grid(j))^2 + (k * grid_size_z)^2); % 计算网格单元的中心位置
                if r ~= 0
                    updated_density(k, j) = updated_density(k, j) + alpha * residual(i) / r; % 使用简单梯度下降方法更新密度模型
                end
            end
        end
    end
end
