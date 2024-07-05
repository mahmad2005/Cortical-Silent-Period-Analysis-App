% Sample data with all negative values
data = [-1, -1, -1, -1, -2, -3, -1, -1, -1, -1, -20, -23, -22, -20, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -50, -52, -51, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -80, -30, -81, -2, -82, -1, -1, -1, -1, -1, -1];

% Invert the data to use findpeaks for local minima
inverted_data = -data;

% Find peaks (local minima in original data) with a minimum peak distance
min_peak_distance = 5; % Adjust based on the desired separation between peaks
[peaks, locs] = findpeaks(inverted_data, 'MinPeakDistance', min_peak_distance);

% Get the actual negative values of these peaks
negative_peaks = -peaks;

% Display peaks and their indices
disp('Negative peaks and their indices:');
disp(table(locs', negative_peaks', 'VariableNames', {'Index', 'NegativePeakValue'}));

% Sort peaks by value (most negative) and get the indices of the top three peaks
[sorted_peaks, sort_idx] = sort(negative_peaks, 'ascend'); % Ascend to get most negative values
top_three_peaks = sorted_peaks(1:3);
top_three_indices = locs(sort_idx(1:3));

% Display the top three negative peaks and their indices
disp('Top three negative peaks and their indices:');
disp(table(top_three_indices', top_three_peaks', 'VariableNames', {'Index', 'NegativePeakValue'}));
