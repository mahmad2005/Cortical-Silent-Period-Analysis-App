
function top_indices = getAscendedSignificantPeaksIndices(data, min_peak_distance, isReversed) 
    % min_peak_distance: Adjust based on the desired separation between peaks
    % isReversed for negative peaks detection
  
    if isReversed == 1
        oneMult = -1;
    else
        oneMult = 0;
    end 
    
    % Invert the data to use findpeaks for local minima
    inverted_data = oneMult* data;

    % Find peaks (local minima in original data) with a minimum peak distance
    [peaks, locs] = findpeaks(inverted_data, 'MinPeakDistance', min_peak_distance);

    % Get the actual negative values of these peaks
    negative_peaks = oneMult* peaks;


    % Sort peaks by value (most negative) and get the indices of the top three peaks
    [sorted_peaks, sort_idx] = sort(negative_peaks, 'ascend'); % Ascend to get most negative values
    
    top_indices = locs(sort_idx);
end 