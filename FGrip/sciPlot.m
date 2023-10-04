% Data
% Simulink BRAM WNS
Frequency1 = [10, 50, 100, 200, 300, 400, 500];
WNS1_8bit = [95.559, 15.56, 5.56, 0.816, 0.107, -0.736, -1.212];
WNS1_16bit = [95.862, 16.382, 6.382, 1.382, 0.128, -0.556, -1.205];
WNS1_32bit = [94.126, 14.03, 4.03, -0.67, -2.337, -3.17, -3.67];

% Vivado BRAM WNS
Frequency2 = [10, 50, 100, 200, 300, 400, 500];
WNS2_8bit = [88.947, 9.129, 0.535, -3.838, -5.405, -6.28, -6.78];
WNS2_16bit = [88.065, 8.065, -1.935, -6.935, -8.605, -9.435, -9.935];
WNS2_32bit = [86.289, 6.289, -1.051, -6.11, -7.661, -8.528, -9.072];

% Simulink CORDIC IP WNS
Frequency3 = [10, 50, 100, 200, 300, 400, 500];
WNS3_8bit = [73.44, 0.014, -9.04, -13.5, -15.626, -16.162, -16.692];
WNS3_16bit = [40.136, -20.678, -30.857, -35.682, -37.748, -38.862, -39.292];
WNS3_32bit = [-1.74, -79.358, -89.3401, -94.366, -95.939, -96.335, -96.754];

% Vivado CORDIC IP WNS
Frequency4 = [10, 50, 100, 200, 300, 400, 500];
WNS4_8bit = [96.367, 16.378, 6.378, 1.661, 0.372, -0.172, -0.686];
WNS4_16bit = [94.524, 15.618, 6.072, 1.108, -0.011, -0.482, -1.187];
WNS4_32bit = [92.887, 13.43, 4.783, 0.572, -0.704, -1.274, -1.806];

% Create a single figure with four subplots
figure;

% Subplot for Simulink BRAM WNS
subplot(2, 2, 1);
bar(Frequency1, [WNS1_8bit', WNS1_16bit', WNS1_32bit'], 'grouped');
title('Simulink BRAM WNS');
xlabel('Frequency(MHz)');
ylabel('Worst Negative Slack (ns)');
legend({'8-bit', '16-bit', '32-bit'}, 'Location', 'best', 'FontSize', 8);

% Subplot for Vivado BRAM WNS
subplot(2, 2, 2);
bar(Frequency2, [WNS2_8bit', WNS2_16bit', WNS2_32bit'], 'grouped');
title('Vivado BRAM WNS');
xlabel('Frequency(MHz)');
ylabel('Worst Negative Slack (ns)');
legend({'8-bit', '16-bit', '32-bit'}, 'Location', 'best', 'FontSize', 8);

% Subplot for Simulink CORDIC IP WNS
subplot(2, 2, 3);
bar(Frequency3, [WNS3_8bit', WNS3_16bit', WNS3_32bit'], 'grouped');
title('Simulink CORDIC IP WNS');
xlabel('Frequency(MHz)');
ylabel('Worst Negative Slack (ns)');
legend({'8-bit', '16-bit', '32-bit'}, 'Location', 'best', 'FontSize', 8);

% Subplot for Vivado CORDIC IP WNS
subplot(2, 2, 4);
bar(Frequency4, [WNS4_8bit', WNS4_16bit', WNS4_32bit'], 'grouped');
title('Vivado CORDIC IP WNS');
xlabel('Frequency(MHz)');
ylabel('Worst Negative Slack (ns)');
legend({'8-bit', '16-bit', '32-bit'}, 'Location', 'best', 'FontSize', 8);

% Adjust the overall figure title
sgtitle('Frequency vs WNS for Different Implementations');



% Data
BitSize = [8, 16, 32];
BRAM_Simulink = [300, 300, 100];
BRAM_Vivado = [100, 83.33, 12];
CORDIC_Simulink = [50, 10, 10];
CORDIC_Vivado = [300, 200, 200];

% Create a bar plot
figure;
bar(BitSize, [BRAM_Simulink', BRAM_Vivado', CORDIC_Simulink', CORDIC_Vivado'], 'grouped');

% Set the title and axis labels
title('Maximum Frequency for different implementations');
xlabel('Bit-size');
ylabel('Maximum Frequency (MHz)');
legend({'BRAM Simulink', 'BRAM Vivado', 'CORDIC Simulink', 'CORDIC Vivado'}, 'Location', 'best', 'FontSize', 8);

% Display the plot
grid on;





% Data
Frequency = [10, 50, 100, 200, 300, 400, 500];
BRAM_Simulink = [0.112, 0.143, 0.181, 0.258, 0.333, 0.417, 0.493];
BRAM_Vivado = [0.108, 0.123, 0.142, 0.179, 0.216, 0.253, 0.29];
CORDIC_Simulink = [0.114, 0.15, 0.196, 0.29, 0.383, 0.476, 0.569];
CORDIC_Vivado = [0.114, 0.15, 0.195, 0.287, 0.376, 0.46, 0.553];

% Create a line graph
figure;
plot(Frequency, BRAM_Simulink, '-o', 'LineWidth', 1.5);
hold on;
plot(Frequency, BRAM_Vivado, '-s', 'LineWidth', 1.5);
plot(Frequency, CORDIC_Simulink, '-d', 'LineWidth', 1.5);
plot(Frequency, CORDIC_Vivado, '-^', 'LineWidth', 1.5);
hold off;

% Set the title, axis labels, and legend
title('Power requirement for 16-bit implementation');
xlabel('Frequency(MHz)');
ylabel('On-Chip Power (watt)');
legend({'BRAM Simulink', 'BRAM Vivado', 'CORDIC Simulink', 'CORDIC Vivado'}, 'Location', 'best', 'FontSize', 8);

% Display the plot
grid on;




% Data for 16-bit 8 Neurons
Methods_16bit = {'Simulink BRAM', 'Simulink CORDIC', 'Vivado BRAM', 'Vivado CORDIC'};
LUT_16bit = [3923, 8490, 344, 7939];
FF_16bit = [8184, 1392, NaN, 7776]; % NaN for missing data

% Data for 32-bit 8 Neurons
Methods_32bit = {'Simulink BRAM', 'Simulink CORDIC', 'Vivado BRAM', 'Vivado CORDIC'};
LUT_32bit = [11775, 30788, 1459, 30061];
FF_32bit = [21216, 3048, NaN, 28865]; % NaN for missing data

% Create a single figure with two subplots arranged horizontally
figure;

% Subplot for 16-bit 8 Neurons
subplot(1, 2, 1);
bar(1:4, [LUT_16bit', FF_16bit'], 'grouped');
title('16-bit 8 neurons implementation');
xlabel('Implementation Method');
ylabel('Number of LUT and FF');
set(gca, 'XTick', 1:4, 'XTickLabel', Methods_16bit);
legend({'LUT', 'FF'}, 'Location', 'best', 'FontSize', 8);
grid on;

% Subplot for 32-bit 8 Neurons
subplot(1, 2, 2);
bar(1:4, [LUT_32bit', FF_32bit'], 'grouped');
title('32-bit 8 neurons implementation');
xlabel('Implementation Method');
ylabel('Number of LUT and FF');
set(gca, 'XTick', 1:4, 'XTickLabel', Methods_32bit);
legend({'LUT', 'FF'}, 'Location', 'best', 'FontSize', 8);
grid on;

% Adjust the overall layout
sgtitle('Resource Utilization for Different Implementations');


