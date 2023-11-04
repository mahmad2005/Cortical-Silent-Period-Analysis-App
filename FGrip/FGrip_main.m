clear all;
Data = readcell("E:\Personal\Study\CoOp Work\Participants\Force Grip Data\HNHC\trial1_block1.txt");
 
 EMG = cell2mat(Data(8:end,1));
 Time = cell2mat(Data(8:end,4));
 
 hFig = figure; % Create a new figure
 hFig.Position = [0 400 4000 400];
 plot(Time, EMG);
 hold on;


Data2 = readcell("E:\Personal\Study\CoOp Work\Participants\Force Grip Data\HNHC\HNHC.txt");


N_Time = cell2mat(Data2(7:end,1));
N_EMG = cell2mat(Data2(7:end,2));
absEMG = cell2mat(Data2(7:end,3));
Force = cell2mat(Data2(7:end,4));

%D2Fig = figure; % Create a new figure
%D2Fig.Position = [0 400 4000 400];
plot(N_Time, N_EMG);
%hold on;
plot(N_Time, Force);