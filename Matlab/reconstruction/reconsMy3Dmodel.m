% clear
% clc
% addpath('database');
% load('heimeiziv1.mat');
%
LoadPATH = './database/ImgProjection/';
SavePATH = './database/temp_data/';

for i = 1:181 %length(Proj_img1)
    name_load_original = [LoadPATH,'Pic',num2str(i),'.mat'];
    load(name_load_original);
    IMG = Pic.normal;
    [Len1,Len2] = size(IMG);
    IMG_temp1 = myfilter(IMG,Len1);
    IMG_temp2 = myfilter(IMG',Len2);
    Filtered_transIMG2 = IMG_temp2'+IMG_temp1+IMG;
    name_save = [SavePATH,'Filtered_transIMG2',num2str(i),'mat'];
    save(name_save,'Filtered_transIMG2');
end
k = 0;
depth = max(size(IMG));
for j = 1:10:length(IMG)
    name_load_original = [LoadPATH,'Pic',num2str(j),'.mat'];
    name_load_temp = [SavePATH,'Filtered_transIMG2',num2str(j),'mat'];
    load(name_load_original);
    load(name_load_temp);
    for i = 1:depth
        Filtered_IMG3D(:,:,i) = Filtered_transIMG2;
    end
    if j == 1
        Recons = my3DRerotation(Filtered_IMG3D,-Pic.angle);
    else
        Recons = Recons + my3DRerotation(Filtered_IMG3D,-Pic.angle);
    end
    k = k+1;
end
M1 = max(max(IMG_temp1));
M2 = max(max(IMG_temp2));
M3 = max(max(IMG));

Recons1 = Recons/k;
Recons1(find(Recons1<(ceil(M1+M2+M3)/2)))=0;
figure
clf
isosurface(Recons1(1:2:end,1:2:end,1:2:end))
axis equal;
xlabel('x')
ylabel('y')
zlabel('z')

figure
clf
isosurface(A(1:2:end,1:2:end,1:2:end));
axis equal;
xlabel('x')
ylabel('y')
zlabel('z')
