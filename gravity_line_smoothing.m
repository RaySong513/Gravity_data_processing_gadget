clc;
clear;

filename = 'gravity_line_data.xlsx';
[~, sheetNames] = xlsfinfo(filename);

for i = 1:length(sheetNames)
    data = readtable(filename, 'Sheet', sheetNames{i});
    gravityAnomalies = data{:, 2};
    pointNumber = data{:, 1};
    
    % 使用smoothdata函数进行数据平滑
    smoothedData = smoothdata(gravityAnomalies, 'movmean', 5); % 使用移动平均，窗口大小为5
    
    % 绘制原始数据
    figure;
    plot(gravityAnomalies, 'LineWidth', 2);
    title(['原始布格重力异常曲线 - ', sheetNames{i}]);
    xlabel('测点坐标');
    ylabel('布格重力异常');
    % xlabel('点号');
    % ylabel('布格重力异常 (μGal) ');
    xticks(1:length(pointNumber));
    xticklabels(pointNumber);
    xtickangle(45);
    
    % 绘制平滑数据
    figure;
    plot(smoothedData, 'LineWidth', 2, 'Color', 'red');
    title(['平滑后的布格重力异常曲线 - ', sheetNames{i}]);
    xlabel('测点坐标');
    ylabel('布格重力异常');
    % xlabel('点号');
    % ylabel('布格重力异常 (μGal) ');
    xticks(1:length(pointNumber));
    xticklabels(pointNumber);
    xtickangle(45);

     % 绘制结合图像
    figure;
    plot(gravityAnomalies, 'LineWidth', 1);
    hold on; % 保持图像，用于在同一图中绘制平滑数据
    plot(smoothedData, 'LineWidth', 2, 'Color', 'red');
    hold off;
    title(['原始及平滑后的布格重力异常曲线 - ', sheetNames{i}]);
    xlabel('测点坐标');
    ylabel('布格重力异常');
    % xlabel('点号');
    % ylabel('布格重力异常 (μGal) ');
    
    xticks(1:length(pointNumber));
    xticklabels(pointNumber);
    xtickangle(45); % 调整X轴刻度标签的角度
    
end
