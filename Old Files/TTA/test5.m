% Example data points that look like a parabola
x = -2:0.5:8;
y = x.^2 + 2*x + 1; % For illustration, using a known quadratic equation

figure;
plot(x,y);

% Fit a quadratic polynomial to the points
coefficients = polyfit(x, y, 2);
a = coefficients(1);
b = coefficients(2);
c = coefficients(3); % Not used for slope calculation but included for completeness

% Differentiate the polynomial to get the slope formula: dy/dx = 2ax + b
slopeFormula = @(x) 2*a*x + b;

% Evaluate the slope at various points (e.g., at x = -2, 0, 2)
xPoints = [-2, 0, 2];
slopeAtPoints = slopeFormula(xPoints);

% Display the results
disp('Slope at points:');
disp(arrayfun(@(x, s) sprintf('x = %g, slope = %g', x, s), xPoints, slopeAtPoints, 'UniformOutput', false));







% Define the coefficients of the quadratic equation
a = 1;
b = 2;
c = 1;

% Define the point of tangency
x0 = 1;
y0 = a*x0^2 + b*x0 + c; % Calculate the corresponding y value using the quadratic equation

% Calculate the slope of the tangent line at (x0, y0)
m = 2*a*x0 + b;

% Define the tangent line equation using the point-slope form
tangentLine = @(x) m*(x - x0) + y0;

% Plot the parabola
x = linspace(-2, 4, 400);
y = a*x.^2 + b*x + c;
plot(x, y, 'b', 'LineWidth', 2);
hold on;

% Plot the point of tangency
plot(x0, y0, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');

% Draw the tangent line near the point of tangency
xTangent = linspace(x0-1, x0+1, 100); % Define a range around x0 for the tangent line
yTangent = tangentLine(xTangent);
plot(xTangent, yTangent, 'r--', 'LineWidth', 2);

% Labels and legend
xlabel('x');
ylabel('y');
title('Parabola with Tangent Line at a Point');
legend('Parabola', 'Point of Tangency', 'Tangent Line', 'Location', 'best');
grid on;
hold off;

