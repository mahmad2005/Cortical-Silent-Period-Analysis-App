% fileID = fopen('data2.txt');
% data = textscan(fileID,'%s');
% fclose(fileID);
data= readcell('data2.txt');
DataSize = size(data);

endPoint = 0;
startPoint = endPoint+ 7;
endPoint = startPoint+1999;
Time = data(7:2006,1);
Amplitude = data(7:2006,2);

for i = 1:length(Time)
    TimeD(i) = Time{i};
end 

for i = 1:length(Amplitude)
    AmplitudeD(i) = Amplitude{i};
end 

AmplitudeD = AmplitudeD';
TimeD = TimeD';

f1 = figure;
plot(TimeD, AmplitudeD);