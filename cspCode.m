plainData = Data07;
startPoint = 6025;
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

meanHPdata = 0;
for i = 1:length(hpData)
    meanHPdata(i) = mean(hpData);
    i = i+1;
end 

hold on;
plot(Time, meanHPdata);


rectHPdata = 0;
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
