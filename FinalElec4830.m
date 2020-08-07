%these are for clearing the variables and erasing the command window
clc;
clearvars;
close;
clear;
%loading the data from the folder
load("ELEC4830_Final_project.mat");

%renaming the variables so that these will be temporary
% and if I need the real values again I will call the permanent ones
x_train=trainSpike;
y_train=trainState;
x_test=testSpike;

%this is the distrubition of test dara

number_of_zero = sum(y_train(:)==0);
number_of_one = sum(y_train(:)==1);
number_of_NaN = length(y_train)-number_of_one-number_of_zero;
all_of_them= [number_of_zero number_of_one number_of_NaN ];

%for visualization I will make a pie chart
labels = {'Zeros','Ones','NaNs'};
pie(all_of_them,labels)

%with the find function I found the indices of the O's and 1's
indices_of_zero=find(y_train(:)==0);
indices_of_one=find(y_train(:)==1);

%now I have all zeros and ones but I have to make one concetenated list
indices=zeros(1500,1);

for i=1:750
    indices(i)=indices_of_zero(i);
end
for i=751:1500
    indices(i)=indices_of_one(i-750);
end

%to sort them in order so that they wont lose their order which may be
%important because of the time dependency
indices_sorted=sort(indices);

%selecting the important (non NaN datas)
ones_and_zeros_only_labels=y_train(indices_sorted);
ones_and_zeros_only_features=x_train(:,indices_sorted);

%I would like to seperate the data into two parts since I have nothing to
%check other than the given training labels. I seperate %80 percent to %20
%percent because as I researched I found that in literature this is the
%convenient way to do.

Percentage=0.8;
labels_train = ones_and_zeros_only_labels(:,1:Percentage*length(ones_and_zeros_only_labels));
labels_validate = ones_and_zeros_only_labels(:,Percentage*length(ones_and_zeros_only_labels)+1:length(ones_and_zeros_only_labels));
features_train = ones_and_zeros_only_features(:,1:Percentage*length(ones_and_zeros_only_features));
features_validate = ones_and_zeros_only_features(:,Percentage*length(ones_and_zeros_only_features)+1:length(ones_and_zeros_only_features));

%now I divided them, I will train my neural network and test the rest.

%I want only two hidden layer as I tried more or as I tried less I realized
%that my correctness ( you will see in few lines decrease significnatly )
%from 75-80 to 70-75 percent accuracy.
net = patternnet(2);
net.trainParam.epochs=150;

%This is the learning rate as I changed it this become the best one. The
%differnece was slight but in favor of 0.001 than 0.01
net.trainParam.lr=0.001;

%Normally this was 7 in default but as I tried different ones I found this
%one was giving the best for the test.
net.trainParam.max_fail=10;

%In here I trained my neural network.
[net,tr] = train(net,features_train,labels_train);

%Now it's time to validate if my network is succesfull enough.

validation_part = net(features_validate);
validation_floats= validation_part;

%Since my data is not floats but binary I have to change it into 0's and
%1's.

for j=1:length(validation_part)
    if(validation_part(1,j)<0.5)
        validation_part(1,j)=0;
    else
        validation_part(1,j)=1;
    end
end

%With the find again I can compare the results 
equal=length(find(validation_part(1,:)==labels_validate(1,:)));
correctness= equal/300;
correctness

%In here I am doing the same for my goal

testState1= net(testSpike);
testState_float=testState1;
for j=1:length(testState1)
    if(testState1(1,j)<0.5)
        testState1(1,j)=0;
    else
        testState1(1,j)=1;
    end
end

% I would like to see how much zeros and ones are in the end 
result_zero = sum(testState1(:)==0);
result_one = sum(testState1(:)==1);

%As wanted in the pdf I changed the name and my results dimensions are the
%same as wanted.

decodedState = testState1;
