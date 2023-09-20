% fileID = fopen("baseline10.txt", 'r');
% formatSpec = '%c';
% A = fscanf(fileID,formatSpec);
% 
% A(1:14);


%fileID = fopen('baseline10.txt', 'r');
fileID = fopen('baseline 14.txt', 'r');

% Initialize a cell array to store lines
lines = {};

% Read the file line by line
currentLine = fgetl(fileID);
while ischar(currentLine)
    lines{end+1} = currentLine;
    currentLine = fgetl(fileID);
end

fclose(fileID);

sampleNumber = 8;

charLine = char(lines(sampleNumber));  % 8  to 39
splitLine = strsplit(charLine, '\t');
%T = array2table(C);

sampleData = char(splitLine(26));
splitSampleData = strsplit(sampleData, ';');
doubledSampleData = cellfun(@str2double, splitSampleData);
plot(doubledSampleData);

for i = 8:length(lines)
    charLine = char(lines(i));
    if strcmp(charLine(1:6), 'Sample') || strcmp(charLine(1:6), 'sample')
        numberOfSample = i-8;
    else
        break;
    end
end
