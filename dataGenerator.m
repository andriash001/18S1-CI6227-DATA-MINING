close all;
clear all;
clc

numOfSamples = 500000;

data = zeros(numOfSamples,15);
y = zeros(numOfSamples,4);

for i = 1:numOfSamples    
    
    % adults (18-80)
    age = randi([18 80]);

    % 1 - Male, 2 - Female
    gender = randi([1 2]);

    % Blood Group (A, B, AB, O)(+ve and -ve)
    bloodGroup = randi([1 8]);

    % Blood Pressure (70-200) (Diastolic 70-130)(Systolic 100 - 200)
    diastolicBP = randi([70 130]);
    systolicBP = randi([100 200]);

    % Weight (30-150Kgs)
    weight = randFloat(30,150);

    % Height (100-220cms)
    height = randFloat(100,200); 

    % Body Mass Index
    BMI = weight / (height/100).^2;

    % Exercise Habit (1 - No exercise, 2 - Reglar Exercise)
    exerciseHabit = randi([1 2]);

    % Blood Cholestrol Level (100 - 400 mg\dL)
    bloodCholestrol = randi([100 400]);

    % Parental History (1 - No, 2 - One Parent, 3 - Both Parents)
    parentalHistory = randi([1 3]);

    % Alcohol (1 - No, 2 - Yes)
    alcohol = randi([1 2]);
    
    % Heart Rate (40 - 175 beats per minute)
    heartRate = randi([60 100]);

        
    % Diastole function
    gD = 1;
    if((120<diastolicBP)&&(diastolicBP<140))
        gD = 1.1;
    elseif(diastolicBP>=140)
        gD = 1.25;
    end
    
    % Diastole function
    gS = 1;
    if((120<systolicBP)&&(systolicBP<140))
        gS = 1.1;
    elseif(systolicBP>=140)
        gS = 1.25;
    end
       
    % Blood Group (if AB+ve (index 5) or  AB-ve (index 6))
    gBG = 0;
    if(bloodGroup == 5 || bloodGroup == 6)
        gBG = 10;
    end
    
    % Parental History
    gPH = (1.1).^(-1);
    if(parentalHistory == 2)
        gPH = 1.15;
    elseif(parentalHistory == 3)
        gPH = 1.25;
    end
    
    % Alcohol use
    gA = 0;
    if(alcohol)
        gA = 5;
    end
    
    % Exercise Habit
    gE = 1.15;
    if(exerciseHabit)
        gE = (1.1).^(-1);
    end
    
    % To generate the label
    labelVal = ((age*BMI)/100)+(BMI)+(gD*diastolicBP)+(gS*systolicBP)+gBG+(bloodCholestrol*gPH)+gA+(heartRate*gE);
    
    label = 1;
    if((labelVal>=600)&&(labelVal<700))
        label = 2;
    elseif((labelVal>=700)&&(labelVal<850))
        label = 3;
    elseif(labelVal>=850)
        label = 4;
    end
    data(i,:) = [age gender bloodGroup diastolicBP systolicBP weight height BMI exerciseHabit bloodCholestrol parentalHistory alcohol heartRate labelVal label];
    if label == 1
        y(i,:) = [1 0 0 0];
    elseif label == 2
        y(i,:) = [0 1 0 0];
    elseif label == 3
        y(i,:) = [0 0 1 0];
    elseif label == 4
        y(i,:) = [0 0 0 1];
    end
end
data(:,14) = [];

features = normalize(data(:,1:13),2);
labels = data(:,14);

normalizedData = [features labels];

function randomflt = randFloat(min,max)

    randomflt = (max-min).*rand + min;

end