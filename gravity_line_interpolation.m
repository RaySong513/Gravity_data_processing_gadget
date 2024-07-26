clc;
clear;

filename = 'gravity_line_data.xlsx';
[~, sheetNames] = xlsfinfo(filename);

for i = 1:length(sheetNames)
    data = readtable(filename, 'Sheet', sheetNames{i});
    gravityAnomalies = data{:, 2}; 
    pointNumber = data{:, 1}; 
    
    % 绘制折线图
    figure;
    plot(gravityAnomalies, 'LineWidth', 2);
    title(['插值布格重力异常曲线 - ', sheetNames{i}]);
    xlabel('测点坐标');
    ylabel('布格重力异常');
    % xlabel('点号');
    % ylabel('布格重力异常 (μGal) ');

    xticks(1:length(pointNumber));
    xticklabels(pointNumber);
    xtickangle(45);
end
