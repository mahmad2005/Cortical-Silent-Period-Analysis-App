% clear all;
% BB = [1,2,3,4,5,12,1,6,8,5,6,4,6,2,6,4,28,1,12,16,1,2,3,4,5,6,1,25,38,26,29,2,3,4,6,8,37];
% AA = [6,17,19,20,28,29,30,31,37];
% 
% CC = BB>10;
% 
% i =1;
% j=1;
% while i < length(AA)
%     if abs(AA(i)-AA(i+1))>5
%         newAA(j) = AA(i);
%         j = j+1;
%     end   
%     
%     i = i+1;
% end
% 
% if abs(AA(length(AA)-1)-AA(length(AA)))>5
%     newAA(j) = AA(length(AA));
% end

clear all;
BB = [1,2,3,4,5,14,11,12,13,11,13,11,12,13,1,6,8,5,6,4,6,2,6,4,28,1,12,16,1,2,3,4,5,6,1,25,38,26,29,2,3,4,6,8,37];

% Initialize threshold and span
threshold = 10; % Values greater than this are considered
span = 5; % Maximum index difference to consider as the same cluster

% Initialize variables for result storage
clusterMaxValues = [];
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
                clusterMaxValues = [clusterMaxValues, currentMax];
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
    clusterMaxValues = [clusterMaxValues, currentMax];
    clusterMaxIndices = [clusterMaxIndices, currentMaxIndex];
end

% Display the results
disp('Cluster Max Values:');
disp(clusterMaxValues);
disp('Cluster Max Indices:');
disp(clusterMaxIndices);

onetwo = findClusterMaxIndices(BB,10,5);



span_counter_active = 0;
span_counter = 0;
span = 5;
th =10;
temp_numb = 0;
temp_indx = 0;
j=1;
Spike_numb = zeros;
Spike_indx = zeros;

for i = 1:length(BB)
    if BB(i) > th
        if BB(i) > temp_numb
            span_counter_active = 1;
            span_counter = span;
            temp_numb = BB(i);
            temp_indx = i;
        end
    else
        if span_counter_active == 1 
            span_counter = span_counter -1;
        end
    end
    if i == length(BB)
        span_counter = 0;
        disp('used');
    end
    if (span_counter == 0) && (span_counter_active ==1)
        Spike_numb(j) = temp_numb;
        Spike_indx(j) = temp_indx;
        temp_numb = 0;
        span_counter =0;
        span_counter_active = 0;
        j = j+1;
    end 
end
