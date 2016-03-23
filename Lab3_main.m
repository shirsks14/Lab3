clear all;
close all;



load('feat.mat');
% aplot(f2);
%% Part 3
% res = 2
MICDClassifier_1 = MICDClassifier(f2);
counter = 1;
p = 1;
for i = 1:160
%     point = [sum(f2t(1,counter+1:counter+16))/16, sum(f2t(2,counter+1:counter+16))/16]';
    point = [f2t(1,i), f2t(2,i)]';
    classes(p,counter) = MICDClassifier_1.Classify(point);
    
    if(mod(counter,16) ==0)
        counter = 0;
        p = p+1;
    end
    counter = counter +1;
end

confusion_2 = zeros(10,10);

for i = 1:10
    for j = 1:10
        confusion_2(i,j) = histc(classes(i,:),j);
    end
end

% res = 8

MICDClassifier_2 = MICDClassifier(f2);
counter = 1;
p = 1;
for i = 1:160
%     point = [sum(f2t(1,counter+1:counter+16))/16, sum(f2t(2,counter+1:counter+16))/16]';
    point = [f8t(1,i), f8t(2,i)]';
    classes(p,counter) = MICDClassifier_2.Classify(point);
    
    if(mod(counter,16) ==0)
        counter = 0;
        p = p+1;
    end
    counter = counter +1;
end

confusion_8 = zeros(10,10);

for i = 1:10
    for j = 1:10
        confusion_8(i,j) = histc(classes(i,:),j);
    end
end
% res = 32

MICDClassifier_3 = MICDClassifier(f2);
counter = 1;
p = 1;
for i = 1:160
%     point = [sum(f2t(1,counter+1:counter+16))/16, sum(f2t(2,counter+1:counter+16))/16]';
    point = [f32t(1,i), f32t(2,i)]';
    classes(p,counter) = MICDClassifier_3.Classify(point);
    
    if(mod(counter,16) ==0)
        counter = 0;
        p = p+1;
    end
    counter = counter +1;
end

confusion_32 = zeros(10,10);

for i = 1:10
    for j = 1:10
        confusion_32(i,j) = histc(classes(i,:),j);
    end
end

%% Part 4

% MICDClassifier = MICDClassifier(f8);
% counter = 1;
% p = 1;
for i = 1:256
    for j = 1:256
%     point = [sum(f2t(1,counter+1:counter+16))/16, sum(f2t(2,counter+1:counter+16))/16]';
    point = [multf8(i,j,1), multf8(i,j,2)]';
    cimage(i,j) = MICDClassifier_2.Classify(point);
    
%     if(mod(counter,16) ==0)
%         counter = 0;
%         p = p+1;
%     end
%     counter = counter +1;
    end
end
figure (1)
imagesc(cimage);
figure(2)
imagesc(multim);