clear all;
close all;



load('feat.mat');
%% Part 2

im(1).data = readim(['cloth.im']);
im(2).data = readim(['cotton.im']);
im(3).data = readim(['grass.im']);
im(4).data = readim(['pigskin.im']);
im(5).data = readim(['wood.im']);
im(6).data = readim(['cork.im']);
im(7).data = readim(['paper.im']);
im(8).data = readim(['stone.im']);
im(9).data = readim(['raiffa.im']);
im(10).data = readim(['face.im']);

for i_n = 1:10
    figure(i_n)
    imagesc(im(i_n).data)
    colormap(gray)
end

figure(11)
aplot(f2)
figure(12)
aplot(f8)
figure(13)
aplot(f32)

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

%misclassification rate for each image and for each n

for i = 1 :10
    misclas(1,i) = 1-(confusion_2(i,i)/16);
end

% res = 8

MICDClassifier_2 = MICDClassifier(f8);
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
%misclassification rate for each image and for each n
% for i = 1 :10
%     confusion_2(i,11) = sum(confusion_2(i,1:10));
%     confusion_2(i,12) = sum(confusion_2(i,2:10))/confusion_2(i,11);
% end

for i = 1 :10
    misclas(2,i) = 1-(confusion_8(i,i)/16);
end


% res = 32

MICDClassifier_3 = MICDClassifier(f32);
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

%misclassification rate for each image and for each n
% for i = 1 :10
%     confusion_2(i,11) = sum(confusion_2(i,1:10));
%     confusion_2(i,12) = sum(confusion_2(i,2:10))/confusion_2(i,11);
% end

for i = 1 :10
    misclas(3,i) = 1-(confusion_32(i,i)/16);
end

for i = 1:3
    misclas(i,11) = mean(misclas(i,1:10));
end

%% Part 4

% MICDClassifier = MICDClassifier(f8);??
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

figure(14)
imagesc(cimage);
colormap(gray)
figure(15)
imagesc(multim);
colormap(gray)

%% Part 5

k = 10;
random = randi(160, 10, 1);
allPoints = zeros(2,10);
NoofPoints = zeros(1,10);
for i = 1:k
    means(:,i) = [f32(1,random(i)) f32(2,random(i))]';
end

for i = 1:160
    point = [f32(1,i), f32(2,i)]';
    class = Lab3Utils.ClassifyClass(means,point);
    allPoints(:,class) = allPoints(class) + point;
    NoofPoints(class) = NoofPoints(class)+1;
end

for i = 1:k
    N = NoofPoints(i);
    if(N ~= 0)
        means(:,i) = [allPoints(1,i)/N allPoints(2,i)/N]';
    else
        means(:,i) = [0 0]';
    end
end
    
figure(16)
scatter(means(1,:), means(2,:), 'r');
hold on
scatter(f32(1,:), f32(2,:), 'b');

%% Fuzzy k-mean
[center,u]=fcm(f32,2);