clear
clc
SavePATH = './database/ImgProjection/';
% name = [SavePATH,'SAMuser',num2str(userNum(i)),'.mat'];
a = ones(23,45,33);
b = ones(20,20,20);
A = zeros(67,67,67);
%A(33-11:33+11,33-22:33+22,33-16:33+16)=a;
A(14:36,2:46,16:48)=a;
A(34:53,47:66,36:55)=b;

% addpath('database');
% load('v1.mat');
% angle(:,1)=1:10:180;
% angle(:,2)=1:10:180;
k = 1;
for i = 0:5:180
    for j = 0;
        angle(k,1)=i;
        angle(k,2)=j;
        k = k+1;
    end
end
for i = 0
    for j = 5:5:180;
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
    % Rot3D{i} = Rot_img;
    proj_img = zeros(size(Rot_img(:,:,1)));
    for j = 1:size(Rot_img,3)
        proj_img = proj_img + Rot_img(:,:,j);
    end
    Proj_img1=proj_img;
    proj_img(find(proj_img~=0))=1;
    Proj_img2= proj_img;
    Pic.inte = Proj_img1;
    Pic.normal = Proj_img2;
    Pic.angle = angle(i,:);
    name = [SavePATH,'Pic',num2str(i),'.mat'];
    save(name,'Pic');
    i
end
    