clc;
clear;

filename = 'gravity_line_data_test.xlsx';
data = readtable(filename);

x = data{:,1};
expansion = 1000; %扩张值
gravity_anomaly = data{:,2} * expansion;

x_interp = linspace(min(x), max(x), 10*length(x)); % 插值点
gravity_anomaly_interp = interp1(x, gravity_anomaly, x_interp, 'linear'); % 插值
gravity_anomaly_smooth = smooth(gravity_anomaly_interp, 0.1, 'loess'); % 平滑处理

% 设置反演参数
grid_size_x = 1; % 横向网格大小，以米为单位
grid_size_z = 0.1; % 纵向网格大小，以米为单位
depth = 2; % 最大深度，以米为单位
depth_levels = ceil(depth / grid_size_z); % 计算纵向网格数量

% 网格化x轴
x_min = min(x_interp);
x_max = max(x_interp);
x_grid = x_min:grid_size_x:x_max;

% 进行线性回归反演
depth_profile = linear_regression_inversion(x_interp, gravity_anomaly_smooth, x_grid, grid_size_x, grid_size_z, depth_levels);

figure;

% 绘制原始和平滑后的重力异常值曲线
subplot(3,1,1);
plot(x, gravity_anomaly / expansion, 'b-', 'DisplayName', '原始重力异常值', 'LineWidth', 1);
hold on
plot(x_interp, gravity_anomaly_smooth / expansion, 'r-', 'DisplayName', '插值平滑后的重力异常值', 'LineWidth', 1);
xlabel('测线位置 (米)');
ylabel('重力异常值');
title('重力异常值曲线');
legend('show');
grid on;

% 绘制反演得到的密度分界面轮廓线
subplot(3,1,2);
%plot(x_grid, depth_profile, 'b-', 'LineWidth', 2);
plot(x_grid, depth_profile, 'LineWidth', 2);
set(gca, 'YDir', 'reverse'); % 反转y轴，使深度从上到下
xlabel('测线位置 (米)');
ylabel('深度 (米)');
title('密度分界面深度轮廓线');
grid on;

% 绘制实地实际地形构造剖面图并填色
subplot(3,1,3);
[XX, ZZ] = meshgrid(x_grid, (0:depth_levels)*grid_size_z);
density_map = NaN(size(XX));
for i = 1:length(x_grid)
    for j = 1:depth_levels
        if ZZ(j,i) <= depth_profile(i)
            density_map(j,i) = depth_profile(i);
        end
    end
end

imagesc(x_grid, (0:depth_levels)*grid_size_z, density_map);
colormap('jet');
colorbar;
set(gca, 'YDir', 'reverse'); % 反转y轴，使深度从上到下
xlabel('测线位置 (米)');
ylabel('深度 (米)');
title('实地实际地形构造剖面图');
grid on;

% 线性回归反演函数
function depth_profile = linear_regression_inversion(x, gravity_anomaly, x_grid, grid_size_x, grid_size_z, depth_levels)
    depth_profile = zeros(size(x_grid)); % 初始化深度轮廓
    for i = 1:length(x_grid)
        [~, idx] = min(abs(x - x_grid(i))); % 找到当前网格点周围的数据点
        if idx > 1 && idx < length(x)
            x_local = x(idx-1:idx+1);
            gravity_local = gravity_anomaly(idx-1:idx+1);
            p = polyfit(x_local, gravity_local, 1); % 使用线性回归进行拟合
            depth_profile(i) = -p(1) * grid_size_z; % 根据线性关系计算深度
        end
    end
end
