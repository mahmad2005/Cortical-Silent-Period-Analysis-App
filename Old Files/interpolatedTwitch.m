clear all;
InterpolData =readcell("P02_08092022_ITT_Post.txt"); 
Datalength = length(InterpolData);
Time = InterpolData(7:Datalength,1);
EMG = InterpolData(7:Datalength,2);
Force = InterpolData(7:Datalength,4);


for i = 1:length(Time)
    TimeD(i) = Time{i};
end 

for i = 1:length(EMG)
    EMGD(i) = EMG{i};
end 

for i = 1:length(Force)
    ForceD(i) = Force{i};
end 

EMGD = EMGD';
TimeD = TimeD';
ForceD = ForceD';

f1 = figure;
plot(TimeD, EMGD);
hold on;
plot(TimeD, ForceD);

EMGD_index = zeros;
j =1;
peaked =0;
for i = 7:length(EMGD)
    if peaked ==0
        if EMGD(i) <= -5
            EMGD_index(j) = i;
            j = j+1;
            peaked =i;
        end
    else
        if i > (peaked+10)
            peaked = 0;
        end 
    end
end

EMGD_index;

hold on;
plot(TimeD(EMGD_index), EMGD(EMGD_index), '-o')

hold on;
plot(TimeD(EMGD_index), ForceD(EMGD_index), '-o');


[~,idx] = max(ForceD(EMGD_index(1): EMGD_index(1)+600));
hold on;
plot(TimeD(EMGD_index(1)+idx), ForceD(EMGD_index(1)+idx), '-o');
intTwitchHeight_1 = abs(ForceD(EMGD_index(1)+idx) - ForceD(EMGD_index(1)));
txt = ['iT_1: ' num2str(intTwitchHeight_1)];
text(TimeD(EMGD_index(1)+idx+10),ForceD(EMGD_index(1)+idx+20)-0.10,txt);
lineX = [TimeD(EMGD_index(1)+idx) TimeD(EMGD_index(1)+idx)];
lineY = [ForceD(EMGD_index(1)+idx) ForceD(EMGD_index(1))];
line( lineX,lineY,Color="red");





[~,idx] = max(ForceD(EMGD_index(2): EMGD_index(2)+600));
hold on;
plot(TimeD(EMGD_index(2)+idx), ForceD(EMGD_index(2)+idx), '-o');
intTwitchHeight_2 = abs(ForceD(EMGD_index(2)+idx) - ForceD(EMGD_index(2)));
txt = ['iT_2: ' num2str(intTwitchHeight_2)];
text(TimeD(EMGD_index(2)+idx+10),ForceD(EMGD_index(2)+idx+20)-0.10,txt);



[~,idx] = max(ForceD(EMGD_index(3): EMGD_index(3)+600));
hold on;
plot(TimeD(EMGD_index(3)+idx), ForceD(EMGD_index(3)+idx), '-o');
intTwitchHeight_3 = abs(ForceD(EMGD_index(3)+idx) - ForceD(EMGD_index(3)));
txt = ['iT_3: ' num2str(intTwitchHeight_3)];
text(TimeD(EMGD_index(3)+idx+10),ForceD(EMGD_index(3)+idx+20)-0.10,txt);