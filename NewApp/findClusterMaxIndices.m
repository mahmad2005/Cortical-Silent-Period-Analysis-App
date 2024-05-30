function clusterMaxIndices = findClusterMaxIndices(BB, threshold, span)
    % Initialize variables for result storage
    clusterMaxIndices = [];

    % Variables to track the current cluster's maximum value and its index
    currentMax = -inf;
    currentMaxIndex = -1;
    lastHighValueIndex = -inf; % Index of the last number exceeding the threshold

    for i = 1:length(BB)
        if BB(i) > threshold
            % Check if current value is within span of the last high value
            if i - lastHighValueIndex <= span
                % Part of the same cluster, update maximum if this value is greater
                if BB(i) > currentMax
                    currentMax = BB(i);
                    currentMaxIndex = i;
                end
            else
                % New cluster, save previous cluster's max and its index
                if currentMax > -inf
                    clusterMaxIndices = [clusterMaxIndices, currentMaxIndex];
                end
                currentMax = BB(i);
                currentMaxIndex = i;
            end
            lastHighValueIndex = i; % Update index of last high value
        end
    end

    % Check for the last cluster
    if currentMax > -inf
        clusterMaxIndices = [clusterMaxIndices, currentMaxIndex];
    end

end
