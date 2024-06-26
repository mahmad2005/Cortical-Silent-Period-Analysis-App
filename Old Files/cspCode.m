
% plainData = Data08;
% startPoint = 7; %7, 2013, 4019, 6025, 8031, 10037
% endPoint = startPoint+1999;
% Time = plainData.Time(startPoint:endPoint);
% Amplitude = plainData.Amplitude(startPoint:endPoint);

%Data =readcell("CSP_FDI_PRE_01.txt");
Data =readcell("TMS_CSP_03232022_pre.txt");
%Data2 =readtable("TMS_CSP_03232022_pre.txt",'PreserveVariableNames',true);
Data2 =readtable("data2.txt",'PreserveVariableNames',true);
nn = 20;
samplingFreq = 1999; % 1199;
startPoint = 1+((samplingFreq+7)*(nn-1)); %7, 2013, 4019, 6025, 8031, 10037
endPoint = startPoint+samplingFreq;
Time = Data2(startPoint:endPoint,1);
Amplitude = Data2(startPoint:endPoint,2);

% TimeD =zeros;
% for i = 1:length(Time)
%     TimeD(i) = Time{i};
% end 
% 
% AmplitudeD=zeros;
% for i = 1:length(Amplitude)
% 
%     AmplitudeD(i) = Amplitude{i};
%     if isnan(AmplitudeD(i))
%         AmplitudeD(i) = AmplitudeD(i-1);
%     end
% end 

TimeD = Time{:,:};
AmplitudeD = Amplitude{:,:};


SignalBias = (sum(AmplitudeD(1:10))/10)*(-1); %% AddBias to Signal for leveling it with zero

AmplitudeD = AmplitudeD'+1;
TimeD = TimeD';

Amplitude = AmplitudeD;
Time = TimeD;

f1 = figure;  %%%%%%%%%% figure 1
plot(TimeD, AmplitudeD);


zeroTime = find(Time == 0);
%Max & Min uV & Time
[CSPmaxVal,CSPmaxInx] = max(Amplitude(zeroTime+41:length(Amplitude)));
[CSPminVal,CSPminInx] = min(Amplitude(zeroTime+41:length(Amplitude)));
peak2peak = abs(CSPmaxVal) + abs(CSPminVal);

CSPminInx = CSPminInx+zeroTime+40; 
%end Max & Min uV & Time

[rectMinBefStim, rectMinIdx] = min(Amplitude(1:150));


init_rms = (rms(Amplitude(1:200)));

CSP_Idx = 0;
CSP_idx_Amp = 0;
for i = CSPminInx:-1:1
%     CSP_Idx = CSPminInx-i+1;
%     Cameron2(i) = i;
%     Cameron(i) = Amplitude(CSPminInx-i+1);
    if (Amplitude(i)) >= init_rms
        break;
    end
    CSP_Idx = i;
end
%CSP_Idx = CSP_Idx;


hpData = highpass(Amplitude,50,1e3);
f2 = figure; plot(Time,hpData); %%%%%%%%%% figure 2
hpData = highpass(hpData,50,1e3);
f3 = figure; plot(Time,hpData); %%%%%%%%%% figure 3
hpData = highpass(hpData,50,1e3);

f4 = figure;                    %%%%%%%%%% figure 4
f4.Position=[-30   250   560   420];
plot(Time, hpData);

meanHPdata = zeros;
for i = 1:length(hpData)
    meanHPdata(i) = mean(hpData);
    %i = i+1;
end 

hold on;
plot(Time, meanHPdata);


rectHPdata = zeros;
for i = 1:length(hpData)
    if hpData(i)> mean(hpData)
        rectHPdata(i) = mean(hpData);
    else
        rectHPdata(i) = hpData(i);
    end 
    %i = i+1;
end 

f5 = figure;                   %%%%%%%%%% figure 5
f5.Position=[480   250   560   420];
plot(Time, rectHPdata);
hold on;
plot(Time, (meanHPdata-0.010));

[rectMinBefStim, rectMinIdx] = min(rectHPdata(1:150));
hold on;
plot(Time(rectMinIdx), rectMinBefStim, '-o');
rectMinBefStim = rectMinBefStim*0.8;
rectMinBefStimLine = repmat(rectMinBefStim, 1, length(Time));
plot(Time, rectMinBefStimLine);

zeroTime = find(Time == 0);
spOnSet = 0;
spOnSetIndex =0;

for i = (zeroTime+20):length(Amplitude)
    if Amplitude(i) <= -0.11
        spOnSet = Time(i);
        spOnSetIndex = i;
        break;
    end 
    %i = i+1;
end 

f6 = figure;                   %%%%%%%%%% figure 6
f6.Position=[990  250   560   420];
plot(Time, Amplitude);
hold on;
plot(spOnSet,0, '-o');

spSearchPoint = find(Time == (spOnSet+0.05));

spOffSet = 0;
for i = spSearchPoint:length(Amplitude)
    if rectHPdata(i) < (meanHPdata-0.010)
        spOffSet = Time(i);
        break;
    end 
    %i = i+1;
end

hold on;
plot(spOffSet,0, '-o');

lineX = [spOnSet spOffSet];
lineY = [0 0];
line(lineX, lineY);

CorticalSilentPeriod = spOffSet - spOnSet;

txt = ['CSP: ' num2str(CorticalSilentPeriod) ' ms'];
text(spOnSet+0.01,-0.10,txt);

[maxVal,maxInx] = max(Amplitude(zeroTime+20:length(Amplitude)));
plot(Time(maxInx+zeroTime+19), maxVal, '-o');
[FirstResp_minVal,FirstResp_minIndx] = min(AmplitudeD(zeroTime+41:length(AmplitudeD)));
plot(Time(FirstResp_minIndx+zeroTime+40), FirstResp_minVal, '-o');


FirstResp_minIndx = FirstResp_minIndx+zeroTime+40; 

[MinBefStim, MinIdx] = min(AmplitudeD(1:150));
MinBefStim = MinBefStim*0.5;

plot(Time(MinIdx), MinBefStim, '-o');

%This chunk added new 11.04.2023
CSP_onSet_Indx = 0;
CSP_onSet_Indx_Amp = 0;
%OnsetArray =zeros;
for i = 1:FirstResp_minIndx
    if (AmplitudeD(FirstResp_minIndx+1-i)) >= MinBefStim
        break;
    end
    CSP_onSet_Indx = FirstResp_minIndx+1-i;
    CSP_onSet_Indx_Amp = AmplitudeD(FirstResp_minIndx+1-i);
    %OnsetArray(i)  = AmplitudeD(FirstResp_minIndx+1-i);
end

plot(Time(CSP_onSet_Indx), CSP_onSet_Indx_Amp, '-o');
plot(Time(10), 0, '-o');
                    
                    
                    

% 
% 
% f7 = figure;                %%%%%%%%%% figure 7
% fp = islocalmin(Amplitude);
% plot(Time, (fp));
% 
% 
% 
% 
% x = Time;
% A = Amplitude;
% TF = islocalmin(A);
% %plot(x,A,x(TF),A(TF),'r*');
% plot(x,A);
% hold on;
% % stp = zeroTime+20;
% % cutAmp = Amplitude(stp:2000);
% % [maxVal,maxInx] = max(cutAmp);
% % [minVal,minInx] = min(cutAmp);
% % maxInx_stp = maxInx+stp-1;
% % minInx_stp = minInx+stp-1;
% % plot(Time(maxInx_stp), Amplitude(maxInx_stp), '-o');
% % hold on;
% % plot(Time(minInx_stp), Amplitude(minInx_stp), '-o');
% 
% % xPosition = round((minInx_stp+maxInx_stp)/2);
% % lineX1 = [Time(xPosition) Time(xPosition)];
% % lineY1 = [Amplitude(minInx_stp) Amplitude(maxInx_stp)];
% % line(lineX1, lineY1,Color="red");
% 
% % lineX2 = [Time(minInx_stp) Time(maxInx_stp)];
% % lineY2 = [Amplitude(maxInx_stp) Amplitude(maxInx_stp)];
% % line(lineX2, lineY2,Color="red");
% 
% % lineX3 = [Time(minInx_stp) Time(maxInx_stp)];
% % lineY3 = [Amplitude(minInx_stp) Amplitude(minInx_stp)];
% % line(lineX3, lineY3,Color="red");
% % 
% % lineX4 = [Time(maxInx_stp) Time(maxInx_stp)];
% % lineY4 = [Amplitude(minInx_stp) Amplitude(maxInx_stp)];
% % line(lineX4, lineY4,Color="red");
% % 
% % lineX5 = [Time(minInx_stp) Time(minInx_stp)];
% % lineY5 = [Amplitude(minInx_stp) Amplitude(maxInx_stp)];
% % line(lineX5, lineY5,Color="red");
% 
% % motorPotential = Amplitude(maxInx_stp) - Amplitude(minInx_stp);
% % txt = ['Potential: ' num2str(motorPotential) ' mV'];
% % text(Time(minInx_stp),Amplitude(minInx_stp)-0.40,txt);
% 
% %hold on;
% % [px,py]= ginput(1);
% % plot(px,py,'*');
% %buton= 0;
% cnt = 0;
% roi_x=zeros;
% roi_y=zeros;
% while 1
%     [px,py,buton]= ginput(1);
%     plot(px,py,'*');
%     lineX6 = [px px];
%     lineY6 = [py-0.5 py+0.5];
%     line(lineX6, lineY6,Color="red");
%     if buton == 1
%         cnt = cnt+1;
%         roi_x(cnt)=px;
%         roi_y(cnt)=py;
%         %buton =0;
%         if cnt ==2 
%             break;
%         end
%     end
% end
% 
% [~,startTime]=min(abs(Time-roi_x(1)));  % find index where the roi_x(1) is closest
% [~,endTime]=min(abs(Time-roi_x(2)));
% %startTime = find(Time == roi_x(1));
% %endTime = find(Time == roi_x(2));
% stp = startTime;
% cutAmp = Amplitude(stp:endTime);
% [maxVal,maxInx] = max(cutAmp);
% [minVal,minInx] = min(cutAmp);
% maxInx_stp = maxInx+stp-1;
% minInx_stp = minInx+stp-1;
% plot(Time(maxInx_stp), Amplitude(maxInx_stp), '-o');
% hold on;
% plot(Time(minInx_stp), Amplitude(minInx_stp), '-o');
% 
% hold off;
% 