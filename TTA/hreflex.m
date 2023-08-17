classdef hreflex
	properties
      
    end
   methods
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
   
    end 
	
end 



