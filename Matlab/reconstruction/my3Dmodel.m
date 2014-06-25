clear
clc

a = ones(23,45,33);
A = zeros(65,65,65);
A(33-11:33+11,33-22:33+22,33-16:33+16)=a;
angle(:,1)=1:180;
angle(:,2)=1;180;

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
end
    