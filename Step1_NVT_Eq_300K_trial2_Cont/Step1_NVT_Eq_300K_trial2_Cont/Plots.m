clear;
close all;

%Variable declaration  
num_rows = 1001; % 1001 lines of output
num_skip = 2; % To skip 1 - 3 lines of the header

%Open and read the file
fidin = fopen('summary.txt','r');
if fidin == -1
    error ('Fail to open the file. Please check it again.')
end

for i = 1:num_skip
    skip_line = fgetl(fidin);
end

 for i = 1:num_rows
  string = fgetl(fidin);
  num = sscanf(string, '%d %d %f %f %f %f %f %f', [1, 8]);
  data(i,:) = num;
 end

set(0,'defaultfigurecolor','w');

time_min = 0;
time_max = 100;


LW_0 = 1.0;
LW_1 = 3.0;
LW_2 = 4.0;
FS = 40;
MS = 8;

res = 300;
figure_width = 1000;
figure_height = 600;

CLR_1 = [1.0 0.6 0.0];

figure (1)
    
    Y_min = 0;
    Y_max = 500;

    plot(data(:,1)/10000, data(:,6), '-', 'Color', CLR_1, 'LineWidth', LW_0, ...
       'MarkerEdgeColor', CLR_1, 'MarkerFaceColor', 'none', 'MarkerSize', MS); hold on;
    box on;
    xlim([time_min time_max]);
    xticks(time_min:(time_max-time_min)/20:time_max);
    xticklabels({'0', '', '10', '', '20', '', '30', '', '40', '', '50', '', ...
                          '60', '', '70', '', '80', '', '90', '', '100'});
    xtickangle(0);


    ylim([Y_min Y_max]);
    yticks(Y_min:(Y_max-Y_min)/5:Y_max);
    legend('Temperature', 'latex', 'Location', 'NorthEast');
    
    set(gca,'XGrid','off'); 
    set(gca,'GridLineStyle',':');
    set(gca,'LineWidth', LW_0, 'FontSize', FS-6, 'FontWeight', 'normal', 'FontName', 'Times');
    set(get(gca, 'xlabel'), 'String', 'Time (ps)', 'Interpreter', 'Latex', 'FontSize', FS, 'FontWeight', 'bold', 'FontName', 'Times');
    set(get(gca, 'ylabel'), 'String', 'Temperature (K)', 'FontSize', FS, 'FontName', 'Times');
    set(gcf, 'Position', [100, 100, 1000, 600]);
    exportgraphics(gcf, 'WSe2_NVT_restrained_Temp.png', 'Resolution', res, 'ContentType', 'vector');


    figure (2)

    Y_min = -381700;
    Y_max = -381000;
    
    plot(data(:,1)/10000, data(:,4), '-', 'Color', CLR_1, 'LineWidth', LW_0, ...
       'MarkerEdgeColor', CLR_1, 'MarkerFaceColor', 'none', 'MarkerSize', MS); hold on;
    box on;
    xlim([time_min time_max]);
    xticks(time_min:(time_max-time_min)/20:time_max);
    xticklabels({'0', '', '10', '', '20', '', '30', '', '40', '', '50', '', ...
                          '60', '', '70', '', '80', '', '90', '', '100'});
    xtickangle(0);


    ylim([Y_min Y_max]);
    yticks(Y_min:(Y_max-Y_min)/5:Y_max);
    legend('Potential Energy', 'latex', 'Location', 'NorthEast');
    
    set(gca,'XGrid','off'); 
    xtickformat('%.2f');
    ytickformat('%.2f')
    set(gca,'GridLineStyle',':');
    set(gca,'LineWidth', LW_0, 'FontSize', FS-25, 'FontWeight', 'normal', 'FontName', 'Times');
    set(get(gca, 'xlabel'), 'String', 'Time (ps)', 'Interpreter', 'Latex', 'FontSize', FS-25, 'FontName', 'Times');
    set(get(gca, 'ylabel'), 'String', 'Epot (kcal/mol)', 'FontSize', FS-25, 'FontName', 'Times');
    set(gcf, 'Position', [100, 100, 1000, 600]);

    exportgraphics(gcf, 'WSe2_NVT_restrained_PE.png', 'Resolution', res, 'ContentType', 'vector');

    figure (3)

    Y_min = -80;
    Y_max = 180;
    
    plot(data(:,1)/10000, data(:,7), '-', 'Color', CLR_1, 'LineWidth', LW_0, ...
       'MarkerEdgeColor', CLR_1, 'MarkerFaceColor', 'none', 'MarkerSize', MS); hold on;
    box on;
    xlim([time_min time_max]);
    xticks(time_min:(time_max-time_min)/20:time_max);
    xticklabels({'0', '', '10', '', '20', '', '30', '', '40', '', '50', '', ...
                          '60', '', '70', '', '80', '', '90', '', '100'});
    xtickangle(0);


    ylim([Y_min Y_max]);
    yticks(Y_min:(Y_max-Y_min)/5:Y_max);
    legend('Pressure', 'latex', 'Location', 'NorthEast');
    
    set(gca,'XGrid','off'); 
    set(gca,'GridLineStyle',':');
    set(gca,'LineWidth', LW_0, 'FontSize', FS-25, 'FontWeight', 'normal', 'FontName', 'Times');
    set(get(gca, 'xlabel'), 'String', 'Time (ps)', 'Interpreter', 'Latex', 'FontSize', FS, 'FontWeight', 'bold', 'FontName', 'Times');
    set(get(gca, 'ylabel'), 'String', 'Pressure (MPa)', 'FontSize', FS-25, 'FontName', 'Times');
    set(gcf, 'Position', [100, 100, 1000, 600]);
    exportgraphics(gcf, 'WSe2_NVT_restrined_Pressure.png', 'Resolution', res, 'ContentType', 'vector');
        
    