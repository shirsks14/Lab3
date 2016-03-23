clear all;
close all;

load('feat.mat');
% aplot(f2);

MICDClassifier_1 = MICDClassifier(f2);
counter = 0;
for i = 1:10
    point = [sum(f2t(1,counter+1:counter+16))/16, sum(f2t(2,counter+1:counter+16))/16]';
    classes(i) = MICDClassifier_1.Classify(point);
    counter = counter +16;
end
    
