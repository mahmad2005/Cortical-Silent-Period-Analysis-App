clf;
SampleNumber = 3;
PadelThreshold = 5;
BeepThreshold = 2; % 0.04

Data =readcell("E:\Personal\Study\CoOp Work\Participants\Toe Tapping\DMM\dmm\New\dmm_hnlc.txt");
%Data =readcell("DMM_lnlc.txt");
%Data =readcell("dmm_hnlc.txt");
%startPoint = 7; %7, 2013, 4019, 6025, 8031, 10037
%endPoint = startPoint+100999;
TimeFull = Data(1:length(Data), 1);
%Time = Data(startPoint:endPoint,1);
% Foot_Padel = Data(startPoint:endPoint,5);
% Beep = Data(startPoint:endPoint,6);


IntervalIndx = zeros;
j=0;
for i = 1:length(TimeFull)
    if num2str(TimeFull{i}) == "Interval="
        j = j+1;
        IntervalIndx(j) = i;
    end
    if i == length(TimeFull)
        j = j+1;
        IntervalIndx(j) = i+1;
    end 
end 

%SampleLength = IntervalIndx(2)-7;

startPoint = IntervalIndx(SampleNumber)+6;
endPoint = IntervalIndx(SampleNumber+1)-1;
SampleLength = endPoint - startPoint+1;

Foot_Padel = Data(startPoint:endPoint,5);
Beep = Data(startPoint:endPoint,6);
Time = Data(startPoint:endPoint,1);

TimeD =zeros;
for i = 1:SampleLength %length(Time)
    TimeD(i) = Time{i};
end 

Foot_PadelD=zeros;
for i = 1:SampleLength %length(Foot_Padel)

    Foot_PadelD(i) = Foot_Padel{i};
    if isnan(Foot_PadelD(i))
        Foot_PadelD(i) = Foot_PadelD(i-1);
    end
end 

BeepD = zeros;
for i = 1:SampleLength %length(Beep)

    BeepD(i) = Beep{i};
    if isnan(BeepD(i))
        BeepD(i) = Foot_PadelD(i-1);
    end
end 

refLine = zeros;
for i = 1: SampleLength %length(Beep)

    refLine(i) = BeepThreshold;
%     if isnan(BeepD(i))
%         BeepD(i) = Foot_PadelD(i-1);
%     end
end 

BeepPosition = zeros;
BeepDetected = 0;
ResponsePosition =  zeros;
ResponseDetected = 0;

BeepPositionBefResp = zeros;
LastBeepPosition = 0;
j=1;
k=1;
Timer =0;
for i = 1:SampleLength %length(Beep)
    if BeepDetected == 0
        if BeepD(i) > BeepThreshold
            BeepPosition(j) = i;
            LastBeepPosition = i;
            BeepDetected = 1;
            j = j+1;
            ResponseDetected = 0;
        end
    else
        if Timer >= 3000
            BeepDetected =0;
            
            Timer = 0;
            BeepPosition(j) = i;
            j = j+1;
        end
        if ResponseDetected ==0
            if Foot_PadelD(i)>= PadelThreshold
                ResponseDetected = 1;
                ResponsePosition(k) = i;
                BeepPositionBefResp(k) = LastBeepPosition; 
                k=k+1;
            end
        end 
        Timer = Timer+1;
    end
end 

Foot_Padel =Foot_PadelD';
Time = TimeD';
Beep = BeepD';


% Foot_Padel =str2double(Foot_Padel);
% Time = str2double(Time);

OddBeepPosition = BeepPosition(1:2:end);


plot(Time, Foot_Padel);
hold on;
plot(Time, Beep);
hold on;
plot(Time, refLine);
hold on; 
plot(Time(BeepPosition), Beep(BeepPosition), '-o');
hold on;
plot(Time(ResponsePosition), Foot_Padel(ResponsePosition), '-o');
hold on;
plot(Time(BeepPositionBefResp), Beep(BeepPositionBefResp)+10, '-o');

f2 = figure;
plot(Time,Foot_Padel);

f3 = figure;
plot(Time, Beep);


j=1;
Beep_to_Resp = zeros;
number_of_beep = zeros;
for i = 1:length(BeepPositionBefResp)
    Beep_to_Resp(i) = Time(ResponsePosition(i)) - Time(BeepPositionBefResp(i));
    number_of_beep(i) = i;
end 



f4 = figure;
plot(BeepPositionBefResp,number_of_beep);

figure;
plot(number_of_beep, number_of_beep);
