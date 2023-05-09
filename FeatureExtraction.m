%% Kurtosis
clear
clc
data = load('C:\Users\wangr\Desktop\wangrf\颗粒识别\数据\vs.mat');
KU = [];
for k = 1:2000
ku = kurtosis(data.a(k,:));
KU = [KU;ku];
end

%% DWT
x = [];
for k = 1:5
[c,l] = wavedec(data.a(k,:),5,'db5');
a = wrcoef('a',c,l,'db5',4);
m=2;
r=0.25*std(a);
Sam = SampEn(a,m,r);
x = [x;Sam];
end

%% ImageEntropy
Fs = 10000;
a=[];
for k = 1:2000
SampleSig = data.a(k,:);


sf = waveletScattering('Signallength',numel(SampleSig),'SamplingFrequency',Fs);
feat = featureMatrix(sf,SampleSig);

[S1,U1] = scatteringTransform(sf,SampleSig);

lev = 2;
scattergram(sf,S1,'FilterBank',lev);
title(sprintf('',lev));
t=0:0:0;
set(gca,'xtick',t);
set(gca,'ytick',t);
xlabel('');
ylabel('');
saveas(gcf,'save.jpg')

i=imread('save.jpg'); 
I=rgb2gray(i); 
[C,L]=size(I); 
Img_size=C*L; 
G=256; 
H_x=0;
nk=zeros(G,1);
for i=1:C
for j=1:L
Img_level=I(i,j)+1; 
nk(Img_level)=nk(Img_level)+1;
end
end
for k=1:G 
Ps(k)=nk(k)/Img_size; 
if Ps(k)~=0 
H_x=-Ps(k)*log2(Ps(k))+H_x; 
end
end

H_x  
a=[a;H_x];
end
