clc;
clear;

filename = 'gravity_line_data.xlsx';
[~, sheetNames] = xlsfinfo(filename);

for i = 1:length(sheetNames)
    data = readtable(filename, 'Sheet', sheetNames{i});
    gravityAnomalies = data{:, 2};
    pointNumber = data{:, 1}; % 假设点号在第一列

    smoothedData = smoothdata(gravityAnomalies, 'movmean', 5);
    
    % 计算区域场（使用移动平均窗口为5）
    regionalField = movmean(smoothedData, 11, 'Endpoints', 'shrink'); % 窗口半径为5，总宽度为11
    % 计算局部场
    localField = smoothedData - regionalField;
    
    % 绘制平滑数据
    figure;
    plot(smoothedData, 'LineWidth', 2, 'Color', 'blue');
    title(['平滑数据 - ', sheetNames{i}]);
    xlabel('测点坐标');
    ylabel('布格重力异常');
    % xlabel('点号');
    % ylabel('布格重力异常 (μGal) ');
    xticks(1:length(pointNumber));
    xticklabels(pointNumber);
    xtickangle(45);
    
    % 绘制区域场
    figure;
    plot(regionalField, 'LineWidth', 2, 'Color', 'green');
    title(['区域场 - ', sheetNames{i}]);
    xlabel('测点坐标');
    ylabel('布格重力异常');
    % xlabel('点号');
    % ylabel('布格重力异常 (μGal) ');
    xticks(1:length(pointNumber));
    xticklabels(pointNumber);
    xtickangle(45);
    
    % 绘制局部场
    figure;
    plot(localField, 'LineWidth', 2, 'Color', 'red');
    title(['局部场 - ', sheetNames{i}]);
    xlabel('测点坐标');
    ylabel('布格重力异常');
    % xlabel('点号');
    % ylabel('布格重力异常 (μGal) ');
    xticks(1:length(pointNumber));
    xticklabels(pointNumber);
    xtickangle(45);
end
