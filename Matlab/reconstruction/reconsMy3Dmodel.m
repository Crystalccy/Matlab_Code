clear
clc
addpath('database');
load('matlab.mat');
%
[Len1,Len2] = size(Proj_img1{1});
for i = 1:length(Proj_img1)
    IMG = Proj_img1{i};
    IMG_temp1 = myfilter(IMG,Len1);
    IMG_temp2 = myfilter(IMG',Len2);
    Filtered_transIMG2{i} = IMG_temp2'+IMG_temp1+IMG;
end
k = 0;
depth = max(size(Proj_img1{1}));
for j = 1:10:length(Proj_img1)
    for i = 1:depth
        Filtered_IMG3D(:,:,i) = Filtered_transIMG2{j};
    end
    if j == 1
        Recons = my3DRerotation(Filtered_IMG3D,-angle(j,:));
    else
        Recons = Recons + my3DRerotation(Filtered_IMG3D,-angle(j,:));
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
