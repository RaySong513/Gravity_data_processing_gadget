clc;
clear;

filename = 'gravity_line_data.xlsx';
[~, sheetNames] = xlsfinfo(filename);

for i = 1:length(sheetNames)
    data = readtable(filename, 'Sheet', sheetNames{i});
    gravityAnomalies = data{:, 2}; % 假设重力异常在第二列
    pointNumber = data{:, 1}; % 假设点号在第一列
    
    smoothedData = smoothdata(gravityAnomalies, 'movmean', 5);
    
    % 计算水平导数
    horizontalDerivative = diff(smoothedData); % 使用差分计算导数
    horizontalDerivative = [horizontalDerivative; NaN]; % 补充最后一个数据点以匹配长度
    

    figure;
    
    % 绘制平滑数据
    subplot(2, 1, 1);
    plot(smoothedData, 'LineWidth', 2, 'Color', 'blue');
    title(['平滑重力数据 - ', sheetNames{i}]);
    xlabel('测点坐标');
    ylabel('布格重力异常');
    % xlabel('点号');
    % ylabel('布格重力异常 (μGal) ');
    xticks(1:length(pointNumber));
    xticklabels(pointNumber);
    xtickangle(45);
    
    % 绘制水平导数
    subplot(2, 1, 2);
    plot(horizontalDerivative, 'LineWidth', 2, 'Color', 'red');
    title(['水平导数 - ', sheetNames{i}]);
    xlabel('测点坐标');
    ylabel('布格重力异常');
    % xlabel('点号');
    % ylabel('布格重力异常 (μGal) ');
    xticks(1:length(pointNumber));
    xticklabels(pointNumber);
    xtickangle(45);
end
