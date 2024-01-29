EMG = [1,1,2,3,4,5,6,7,3,1,1,1,1,1,1,1,1,1,1,1,1,4,5,6,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,5,6,7,1,1,1,1,1,1,1,1,1,1,1,8,9,1,2,1,2,1,1];

% Logical array where values are greater than 3
aboveThree = EMG > 3;

% Preallocate arrays with NaN
lastValues = NaN(size(EMG));
lastIndices = NaN(size(EMG));

% Initialize index for storing results
resultIndex = 1;

% Iterate through the array
for currentIndex = 1:length(EMG)
    if aboveThree(currentIndex)
        % Find the end of the current sequence
        endIndex = currentIndex;
        while endIndex <= length(EMG) && aboveThree(endIndex)
            endIndex = endIndex + 1;
        end
        % Store the last value of the sequence and its index
        lastValues(resultIndex) = EMG(endIndex - 1);
        lastIndices(resultIndex) = endIndex - 1;
        resultIndex = resultIndex + 1;
        
        % Update currentIndex to the end of the current sequence
        currentIndex = endIndex - 1;
    end
end

% Trim the preallocated arrays to the size of actual results
lastValues = lastValues(~isnan(lastValues));
lastIndices = lastIndices(~isnan(lastIndices));

% Display the results
disp('Last Values of Each Sequence Above 3: ');
disp(lastValues);
disp('Indices of These Last Values: ');
disp(lastIndices);


x = [10, 20, 30, 40, 50, 60, 70, 80, 90];
y = [1, 2, 3, 4, 5, 6, 7, 8, 9];

% Desired y value
y_target = 5.5;

% Interpolate to find the corresponding x value
x_target = interp1(y, x, y_target, 'linear');

% Display the result
disp(['The interpolated value of x when y is ', num2str(y_target), ' is: ', num2str(x_target)]);
