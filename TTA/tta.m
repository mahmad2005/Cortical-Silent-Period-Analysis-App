clf;
%Data =readcell("dmm_hnlc.txt");
startPoint = 7; %7, 2013, 4019, 6025, 8031, 10037
endPoint = startPoint+100999;
TimeFull = Data(1:length(Data), 1);
Time = Data(startPoint:endPoint,1);
Foot_Padel = Data(startPoint:endPoint,5);
Beep = Data(startPoint:endPoint,6);


TimeD =zeros;
for i = 1:length(Time)
    TimeD(i) = Time{i};
end 

Foot_PadelD=zeros;
for i = 1:length(Foot_Padel)

    Foot_PadelD(i) = Foot_Padel{i};
    if isnan(Foot_PadelD(i))
        Foot_PadelD(i) = Foot_PadelD(i-1);
    end
end 

BeepD = zeros;
for i = 1:length(Beep)

    BeepD(i) = Beep{i};
    if isnan(BeepD(i))
        BeepD(i) = Foot_PadelD(i-1);
    end
end 

refLine = zeros;
for i = 1:length(Beep)

    refLine(i) = 0.04;
%     if isnan(BeepD(i))
%         BeepD(i) = Foot_PadelD(i-1);
%     end
end 

SpikePosition = zeros;
SpikeDetected = 0;
j=1;
Timer =0;
for i = 1:length(Beep)
    if SpikeDetected == 0
        if BeepD(i) > 0.04
            SpikePosition(j) = i;
            SpikeDetected = 1;
            j = j+1;
        end
    else
        if Timer >= 3000
            SpikeDetected =0;
            Timer = 0;
            SpikePosition(j) = i;
            j = j+1;
        end
        Timer = Timer+1;
    end
end 

Foot_Padel =Foot_PadelD';
Time = TimeD';
Beep = BeepD';


% Foot_Padel =str2double(Foot_Padel);
% Time = str2double(Time);


plot(Time, Foot_Padel);
hold on;
plot(Time, Beep);
hold on;
plot(Time, refLine);
hold on; 
plot(Time(SpikePosition), Beep(SpikePosition), '-o');

f1 = figure;
plot(Time, Beep);



IntervalIndx = zeros;
j=1;
for i = 1:length(TimeFull)
    if num2str(TimeFull{i}) == "Interval="
        IntervalIndx(j) = i;
        j = j+1;
    end
    %TimeD(i) = Time{i};
end 