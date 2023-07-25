clf;
% SampleNumber = 10;
% PadelThreshold = 5;
% BeepThreshold = 2; % 0.04

Data =readcell("E:\Personal\Study\CoOp Work\CSP_App\Hreflex\Extracted\H-reflex 3.txt");
%Data =readcell ("DMM_lnlc.txt");
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


startSample = 1;
endSample = length(IntervalIndx)-1;

for SampleNumber = startSample : endSample
    [TimeD, AmplitudeD, VoltageD] = xReflexProcessAll(Data, IntervalIndx, SampleNumber);
    hold on;
    plot(TimeD, AmplitudeD);
    plot(TimeD, ((VoltageD.*0.03)-4));
end 




cnt = 0;
roi_x=zeros;
roi_y=zeros;
while 1
    [px,py,buton]= ginput(1);
    plot(px,py,'*');
    lineX6 = [px px];
    lineY6 = [py-0.5 py+0.5];
    line(lineX6, lineY6,Color="red");
    if buton == 1
        cnt = cnt+1;
        roi_x(cnt)=px;
        roi_y(cnt)=py;
        %buton =0;
        if cnt ==2 
            break;
        end
    end
end


[~,Cropped_startTime_1]=min(abs(TimeD-roi_x(1)));  % find index where the roi_x(1) is closest
[~,Cropped_endTime_1]=min(abs(TimeD-roi_x(2)));
stp = Cropped_startTime_1;
CroppedAmp_1 = AmplitudeD(stp:Cropped_endTime_1);
[~,maxInx] = max(CroppedAmp_1);
[~,minInx] = min(CroppedAmp_1);
Cropped_maxInx_stp_1 = maxInx+stp-1;
Cropped_minInx_stp_1 = minInx+stp-1;


plot(TimeD(Cropped_maxInx_stp_1), AmplitudeD(Cropped_maxInx_stp_1), '-o');
hold on;
plot(TimeD(Cropped_minInx_stp_1), AmplitudeD(Cropped_minInx_stp_1), '-o');




cnt = 0;
roi_x=zeros;
roi_y=zeros;
while 1
    [px,py,buton]= ginput(1);
    plot(px,py,'*');
    lineX6 = [px px];
    lineY6 = [py-0.5 py+0.5];
    line(lineX6, lineY6,Color="Green");
    if buton == 1
        cnt = cnt+1;
        roi_x(cnt)=px;
        roi_y(cnt)=py;
        %buton =0;
        if cnt ==2 
            break;
        end
    end
end


[~,Cropped_startTime_2]=min(abs(TimeD-roi_x(1)));  % find index where the roi_x(1) is closest
[~,Cropped_endTime_2]=min(abs(TimeD-roi_x(2)));
stp = Cropped_startTime_2;
CroppedAmp_2 = AmplitudeD(stp:Cropped_endTime_2);
[maxVal,maxInx] = max(CroppedAmp_2);
[minVal,minInx] = min(CroppedAmp_2);
Cropped_maxInx_stp_2 = maxInx+stp-1;
Cropped_minInx_stp_2 = minInx+stp-1;


plot(TimeD(Cropped_maxInx_stp_2), AmplitudeD(Cropped_maxInx_stp_2), '-o');
hold on;
plot(TimeD(Cropped_minInx_stp_2), AmplitudeD(Cropped_minInx_stp_2), '-o');

hold off;


Cropped_1_Peak2Peak_All = zeros;
Cropped_2_Peak2Peak_All = zeros;
Positive_Peak_volt_All = zeros;
Negative_Peak_volt_All =  zeros;
for SampleNumber = startSample : endSample
    [TimeD, AmplitudeD, VoltageD] = xReflexProcessAll(Data, IntervalIndx, SampleNumber);
    [Cropped_1_Peak, Cropped_1_Bottom, Cropped_1_Peak2Peak] = Trial_Cropped_1(AmplitudeD,Cropped_startTime_1, Cropped_endTime_1);
    [Cropped_2_Peak, Cropped_2_Bottom, Cropped_2_Peak2Peak] = Trial_Cropped_2(AmplitudeD,Cropped_startTime_2, Cropped_endTime_2);
    Cropped_1_Peak2Peak_All(SampleNumber) = Cropped_1_Peak2Peak;
    Cropped_2_Peak2Peak_All(SampleNumber) = Cropped_2_Peak2Peak;
    figure;
    plot(TimeD, AmplitudeD);
    hold on;
    plot(TimeD(Cropped_1_Peak),AmplitudeD(Cropped_1_Peak), '-o');
    plot(TimeD(Cropped_1_Bottom),AmplitudeD(Cropped_1_Bottom), '-o');
    plot(TimeD(Cropped_2_Peak),AmplitudeD(Cropped_2_Peak), '-o');
    plot(TimeD(Cropped_2_Bottom),AmplitudeD(Cropped_2_Bottom), '-o');
    
    [Positive_Peak_volt, Negative_Peak_volt] = voltagePeakNbottom(VoltageD);
    Positive_Peak_volt_All(SampleNumber) = Positive_Peak_volt;
    Negative_Peak_volt_All(SampleNumber) = Negative_Peak_volt;
    
    plot(TimeD, ((VoltageD.*0.03)-4));
    hold off;
end 

figure;
hold on;
plot(Cropped_1_Peak2Peak_All, 'LineWidth',2, 'DisplayName','Peak-to-Peak - First Peak');
plot(Cropped_2_Peak2Peak_All, 'LineWidth',2, 'DisplayName','Peak-to-Peak - Second Peak');

if max(abs(Positive_Peak_volt_All)) > max(abs(Negative_Peak_volt_All))
    Peak_volt_All = Positive_Peak_volt_All;
else 
    Peak_volt_All = abs(Negative_Peak_volt_All);
end
plot(Peak_volt_All*0.1,'LineWidth',2, 'DisplayName','Voltage');


legend;






function [Positive_Peak_volt, Negative_Peak_volt] = voltagePeakNbottom(VoltageD)
    Positive_Peak_volt = max(VoltageD);
    Negative_Peak_volt = min(VoltageD);
end 


function [Cropped_1_Peak, Cropped_1_Bottom, Cropped_1_Peak2Peak] = Trial_Cropped_1(AmplitudeD,Cropped_startTime_1, Cropped_endTime_1)
    CroppedAmp_1 = AmplitudeD(Cropped_startTime_1:Cropped_endTime_1);
    [maxVal,maxInx] = max(CroppedAmp_1);
    [minVal,minInx] = min(CroppedAmp_1);
    Cropped_1_Peak2Peak = abs(maxVal) + abs(minVal);
    Cropped_1_Peak = maxInx+Cropped_startTime_1-1;
    Cropped_1_Bottom = minInx+Cropped_startTime_1-1;  
end 

function [Cropped_2_Peak, Cropped_2_Bottom, Cropped_2_Peak2Peak] = Trial_Cropped_2(AmplitudeD,Cropped_startTime_2, Cropped_endTime_2)
    CroppedAmp_2 = AmplitudeD(Cropped_startTime_2:Cropped_endTime_2);
    [maxVal,maxInx] = max(CroppedAmp_2);
    [minVal,minInx] = min(CroppedAmp_2);
    Cropped_2_Peak2Peak = abs(maxVal) + abs(minVal);
    Cropped_2_Peak = maxInx+Cropped_startTime_2-1;
    Cropped_2_Bottom = minInx+Cropped_startTime_2-1;  
end 


function [TimeD, AmplitudeD,VoltageD] = xReflexProcessAll(Data, IntervalIndx, SampleNumber)

    startPoint = IntervalIndx(SampleNumber)+6;
    endPoint = IntervalIndx(SampleNumber+1)-1;
    SampleLength = endPoint - startPoint+1;

    Amplitude = Data(startPoint:endPoint,2);
    Voltage = Data(startPoint:endPoint,3);
    Time = Data(startPoint:endPoint,1);




    TimeD =zeros;
    for i = 1:SampleLength %length(Time)
        TimeD(i) = Time{i};
    end 

    AmplitudeD=zeros;
    for i = 1:SampleLength %length(Foot_Padel)

        AmplitudeD(i) = Amplitude{i};
        if isnan(AmplitudeD(i))
            AmplitudeD(i) = AmplitudeD(i-1);
        end
    end 

    VoltageD = zeros;
    for i = 1:SampleLength %length(Beep)

        VoltageD(i) = Voltage{i};
        if isnan(VoltageD(i))
            VoltageD(i) = VoltageD(i-1);
        end
    end 

end 









