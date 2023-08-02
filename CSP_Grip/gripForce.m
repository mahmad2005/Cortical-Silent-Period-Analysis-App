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