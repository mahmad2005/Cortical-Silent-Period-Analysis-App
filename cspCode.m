%format long;
Data =readcell("Data2.txt");
plainData = Data07;
startPoint = 10037; %7, 2013, 4019, 6025, 8031, 10037
endPoint = startPoint+1999;
Time = plainData.Time(startPoint:endPoint);
Amplitude = plainData.Amplitude(startPoint:endPoint);

hpData = highpass(Amplitude,50,1e3);
figure; plot(Time,hpData);
hpData = highpass(hpData,50,1e3);
figure; plot(Time,hpData);
hpData = highpass(hpData,50,1e3);

f1 = figure;
f1.Position=[-30   250   560   420];
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

f2 = figure;
f2.Position=[480   250   560   420];
plot(Time, rectHPdata);
hold on;
plot(Time, (meanHPdata-0.010));

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

f3 = figure;
f3.Position=[990  250   560   420];
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

figure;
fp = islocalmin(Amplitude);
plot(Time, (fp));

x = Time;
A = Amplitude;
TF = islocalmin(A);
%plot(x,A,x(TF),A(TF),'r*');
plot(x,A);
hold on;
% stp = zeroTime+20;
% cutAmp = Amplitude(stp:2000);
% [maxVal,maxInx] = max(cutAmp);
% [minVal,minInx] = min(cutAmp);
% maxInx_stp = maxInx+stp-1;
% minInx_stp = minInx+stp-1;
% plot(Time(maxInx_stp), Amplitude(maxInx_stp), '-o');
% hold on;
% plot(Time(minInx_stp), Amplitude(minInx_stp), '-o');

% xPosition = round((minInx_stp+maxInx_stp)/2);
% lineX1 = [Time(xPosition) Time(xPosition)];
% lineY1 = [Amplitude(minInx_stp) Amplitude(maxInx_stp)];
% line(lineX1, lineY1,Color="red");

% lineX2 = [Time(minInx_stp) Time(maxInx_stp)];
% lineY2 = [Amplitude(maxInx_stp) Amplitude(maxInx_stp)];
% line(lineX2, lineY2,Color="red");

% lineX3 = [Time(minInx_stp) Time(maxInx_stp)];
% lineY3 = [Amplitude(minInx_stp) Amplitude(minInx_stp)];
% line(lineX3, lineY3,Color="red");
% 
% lineX4 = [Time(maxInx_stp) Time(maxInx_stp)];
% lineY4 = [Amplitude(minInx_stp) Amplitude(maxInx_stp)];
% line(lineX4, lineY4,Color="red");
% 
% lineX5 = [Time(minInx_stp) Time(minInx_stp)];
% lineY5 = [Amplitude(minInx_stp) Amplitude(maxInx_stp)];
% line(lineX5, lineY5,Color="red");

% motorPotential = Amplitude(maxInx_stp) - Amplitude(minInx_stp);
% txt = ['Potential: ' num2str(motorPotential) ' mV'];
% text(Time(minInx_stp),Amplitude(minInx_stp)-0.40,txt);

%hold on;
% [px,py]= ginput(1);
% plot(px,py,'*');
%buton= 0;
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

[~,startTime]=min(abs(Time-roi_x(1)));  % find index where the roi_x(1) is closest
[~,endTime]=min(abs(Time-roi_x(2)));
%startTime = find(Time == roi_x(1));
%endTime = find(Time == roi_x(2));
stp = startTime;
cutAmp = Amplitude(stp:endTime);
[maxVal,maxInx] = max(cutAmp);
[minVal,minInx] = min(cutAmp);
maxInx_stp = maxInx+stp-1;
minInx_stp = minInx+stp-1;
plot(Time(maxInx_stp), Amplitude(maxInx_stp), '-o');
hold on;
plot(Time(minInx_stp), Amplitude(minInx_stp), '-o');

hold off;