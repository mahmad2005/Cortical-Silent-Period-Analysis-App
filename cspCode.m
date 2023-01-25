plainData = plainData;

hpData = highpass(plainData.Amplitude,80,1e3);

f1 = figure;
f1.Position=[-30   250   560   420];
plot(plainData.Time, hpData);

meanHPdata = 0;
for i = 1:length(hpData)
    meanHPdata(i) = mean(hpData);
    i = i+1;
end 

hold on;
plot(plainData.Time, meanHPdata);


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
plot(plainData.Time, rectHPdata);
hold on;
plot(plainData.Time, (meanHPdata-0.010));

zeroTime = find(plainData.Time == 0);
spOnSet = 0;
spOnSetIndex =0;

for i = (zeroTime+20):length(plainData.Amplitude)
    if plainData.Amplitude(i) <= -0.2
        spOnSet = plainData.Time(i);
        spOnSetIndex = i;
        break;
    end 
    %i = i+1;
end 

f3 = figure;
f3.Position=[990  250   560   420];
plot(plainData.Time, plainData.Amplitude);
hold on;
plot(spOnSet,0, '-o');

spSearchPoint = find(plainData.Time == (spOnSet+0.05));

spOffSet = 0;
for i = spSearchPoint:length(plainData.Amplitude)
    if rectHPdata(i) < (meanHPdata-0.010)
        spOffSet = plainData.Time(i);
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
text(spOnSet+0.01,-0.10,txt)
