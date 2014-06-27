clear
clc

a = ones(23,45,33);
b = ones(20,20,20);
A = zeros(67,67,67);
%A(33-11:33+11,33-22:33+22,33-16:33+16)=a;
A(2:24,2:46,2:34)=a;
A(12:31,47:66,22:41)=b;

% addpath('database');
% load('v1.mat');
% angle(:,1)=1:10:180;
% angle(:,2)=1:10:180;
k = 1;
for i = 1:2:180
    for j = 1:2:180
        angle(k,1)=i;
        angle(k,2)=j;
        k = k+1;
    end
end
% A = AA;
figure
clf
isosurface(A)
axis equal;
xlabel('x')
ylabel('y')
zlabel('z')

for i = 1:length(angle(:,1))
    Rot_img = my3Drotation(A,angle(i,:));
    Rot3D{i} = Rot_img;
    proj_img = zeros(size(Rot_img(:,:,1)));
    for j = 1:size(Rot_img,3)
        proj_img = proj_img + Rot_img(:,:,j);
    end
    Proj_img1{i}=proj_img;
    proj_img(find(proj_img~=0))=1;
    Proj_img2{i}= proj_img;
    i
end
    