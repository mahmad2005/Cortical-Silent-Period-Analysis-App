% Example plot
figure;
plot(1:10, rand(1, 10)); % Example data with x-axis starting at 1
hold on;

% Example values for slope and C
slope = 5; % Example slope value
C = 10;    % Example intercept value

% Set the annotation text using normalized coordinates
% 'Units', 'normalized' makes the coordinates relative to the axes
text(0.05, 0.95, {['y = ' num2str(slope) 'x + ' num2str(C)], ['Slope: ' num2str(slope)]}, ...
     'Units', 'normalized', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', ...
     'Color', 'blue', 'FontSize', 10);

% Adjust plot limits if necessary to ensure text visibility
xlim([1 10]);
ylim([0 1]);
