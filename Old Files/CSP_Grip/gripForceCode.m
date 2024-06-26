%Data1 =readcell("MVC_GRIP_L2_PRE.txt");
Data =readtable("MVC_GRIP_R_PRE.txt",'PreserveVariableNames',true);
nn = 1;
samplingFreq = 799; % 1199;
startPoint = 3*nn+(samplingFreq*(nn-1)); %7, 2013, 4019, 6025, 8031, 10037
endPoint = height(Data);

Time = Data(startPoint:endPoint,1);

GripForce = Data(startPoint:endPoint,4);

Time = Time{:,:};
GripForce = GripForce{:,:};

[GripmaxVal, GripmaxIndx] = max(GripForce);
plot(Time,GripForce);
hold on;
plot(Time(GripmaxIndx), GripForce(GripmaxIndx), '-o');
disp(GripmaxVal);
fprintf('%f\n', GripmaxVal)

avgGrip = zeros;
for i = 1:(length(Time)-9999)
    avgGrip(i) = sum(GripForce(i:i+9999)/10000);
end 


%figure;
hold on;
%plot(avgGrip);
[avgGripmaxVal, avgGripmaxIndx] = max(avgGrip);
%plot(avgGripmaxIndx, avgGripmaxVal, '-o');


TimeAvg = Time(10000:length(Time));
avgGrip =  avgGrip';
TimeAtavgVal = Time(round(avgGripmaxIndx+(9999)));

%figure;
plot(TimeAvg, avgGrip);
plot(TimeAtavgVal, avgGripmaxVal, '-o');

lineX = [TimeAtavgVal-1 TimeAtavgVal+0];
lineY = [avgGripmaxVal avgGripmaxVal];
line(lineX , lineY, Color="green");

lineX = [TimeAtavgVal-1 TimeAtavgVal-1];
lineY = [avgGripmaxVal-10 avgGripmaxVal+10];
line(lineX , lineY, Color="red");

lineX = [TimeAtavgVal+0 TimeAtavgVal+0];
lineY = [avgGripmaxVal-10 avgGripmaxVal+10];
line(lineX , lineY, Color="red");
