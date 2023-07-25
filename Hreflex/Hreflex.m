clf;
SampleNumber = 10;
PadelThreshold = 5;
BeepThreshold = 2; % 0.04

Data =readcell("E:\Personal\Study\CoOp Work\CSP_App\Hreflex\Extracted\H-reflex 1.txt");
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

%SampleLength = IntervalIndx(2)-7;
startSample = 1;
%endSample =10;
endSample = length(IntervalIndx)-1;
% for SPN = strt:endSmaple
%     SampleNumber = SPN;
%     startPoint = IntervalIndx(SampleNumber)+6;
%     endPoint = IntervalIndx(SampleNumber+1)-1;
%     SampleLength = endPoint - startPoint+1;
% 
%     Amplitude = Data(startPoint:endPoint,2);
%     Voltage = Data(startPoint:endPoint,3);
%     Time = Data(startPoint:endPoint,1);
% 
% 
% 
% 
%     TimeD =zeros;
%     for i = 1:SampleLength %length(Time)
%         TimeD(i) = Time{i};
%     end 
% 
%     AmplitudeD=zeros;
%     for i = 1:SampleLength %length(Foot_Padel)
% 
%         AmplitudeD(i) = Amplitude{i};
%         if isnan(AmplitudeD(i))
%             AmplitudeD(i) = AmplitudeD(i-1);
%         end
%     end 
% 
%     VoltageD = zeros;
%     for i = 1:SampleLength %length(Beep)
% 
%         VoltageD(i) = Voltage{i};
%         if isnan(VoltageD(i))
%             VoltageD(i) = VoltageD(i-1);
%         end
%     end 
% 
% 
%     plot(TimeD, AmplitudeD);
%     %plot(TimeD, VoltageD);
%     hold on;
% end 

for SampleNumber = startSample : endSample
    [TimeD, AmplitudeD, VoltageD] = xReflexProcessAll(Data, IntervalIndx, SampleNumber);
    plot(TimeD, AmplitudeD);
    %plot(TimeD, VoltageD);
    hold on;
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
%startTime = find(Time == roi_x(1));
%endTime = find(Time == roi_x(2));
stp = Cropped_startTime_1;
CroppedAmp_1 = AmplitudeD(stp:Cropped_endTime_1);
[maxVal,maxInx] = max(CroppedAmp_1);
[minVal,minInx] = min(CroppedAmp_1);
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
%startTime = find(Time == roi_x(1));
%endTime = find(Time == roi_x(2));
stp = Cropped_startTime_2;
CroppedAmp_2 = AmplitudeD(stp:Cropped_endTime_2);
[maxVal,maxInx] = max(CroppedAmp_2);
[minVal,minInx] = min(CroppedAmp_2);
Cropped_maxInx_stp_2 = maxInx+stp-1;
Cropped_minInx_stp_2 = minInx+stp-1;


plot(TimeD(Cropped_maxInx_stp_2), AmplitudeD(Cropped_maxInx_stp_2), '-o');
hold on;
plot(TimeD(Cropped_minInx_stp_2), AmplitudeD(Cropped_minInx_stp_2), '-o');









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










% refLine = zeros(1, SampleLength)+BeepThreshold;
% % for i = 1: SampleLength %length(Beep)
% % 
% %     refLine(i) = BeepThreshold;
% % %     if isnan(BeepD(i))
% % %         BeepD(i) = Foot_PadelD(i-1);
% % %     end
% % end 
% 
% BeepPosition = zeros;
% BeepDetected = 0;
% ResponsePosition =  zeros;
% ResponseDetected = 0;
% 
% BeepPositionBefResp = zeros;
% LastBeepPosition = 0;
% j=1;
% k=1;
% Timer =0;
% for i = 1:SampleLength %length(Beep)
%     if BeepDetected == 0
%         if BeepD(i) > BeepThreshold
%             BeepPosition(j) = i;
%             LastBeepPosition = i;
%             BeepDetected = 1;
%             j = j+1;
%             ResponseDetected = 0;
%         end
%     else
%         if Timer >= 3000
%             BeepDetected =0;
%             
%             Timer = 0;
%             BeepPosition(j) = i;
%             j = j+1;
%         end
%         if ResponseDetected ==0
%             if Foot_PadelD(i)>= PadelThreshold
%                 ResponseDetected = 1;
%                 ResponsePosition(k) = i;
%                 BeepPositionBefResp(k) = LastBeepPosition; 
%                 k=k+1;
%             end
%         end 
%         Timer = Timer+1;
%     end
% end 
% 
% Foot_Padel =Foot_PadelD';
% Time = TimeD';
% Beep = BeepD';
% 
% 
% % Foot_Padel =str2double(Foot_Padel);
% % Time = str2double(Time);
% 
% OddBeepPosition = BeepPosition(1:2:end);
% 
% 
% plot(Time, Foot_Padel);
% hold on;
% plot(Time, Beep);
% hold on;
% plot(Time, refLine);
% hold on; 
% plot(Time(BeepPosition), Beep(BeepPosition), '-o');
% hold on;
% plot(Time(ResponsePosition), Foot_Padel(ResponsePosition), '-o');
% hold on;
% plot(Time(BeepPositionBefResp), Beep(BeepPositionBefResp)+10, '-o');
% 
% f2 = figure;
% plot(Time,Foot_Padel);
% 
% f3 = figure;
% plot(Time, Beep);
% 
% 
% j=1;
% Beep_to_Resp = zeros;
% number_of_beep = zeros;
% for i = 1:length(BeepPositionBefResp)
%     Beep_to_Resp(i) = Time(ResponsePosition(i)) - Time(BeepPositionBefResp(i));
%     number_of_beep(i) = i;
% end 
% 
% 
% 
% f4 = figure;
% plot(BeepPositionBefResp,number_of_beep);
% 
% f5 = figure;
% plot(number_of_beep, Beep_to_Resp);



