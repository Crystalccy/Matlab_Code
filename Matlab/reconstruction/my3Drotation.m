function result = my3Drotation(IMG3D,Angle)
len = size(IMG3D,2);
width = size(IMG3D,3);
hight = size(IMG3D,1);
theta = Angle(1);%*pi/180;
size_ro = ceil(sqrt(len^2+width^2))+4;

% add_width = ceil((size_ro-width)/2);
% add_len = ceil((size_ro-len)/2);
% add_hight = ceil((size_ro-hight)/2);
% 
pre_result = zeros(size_ro,size_ro,size_ro);

% figure;rotate3D
% clf;
% isosurface(IMG3D);
% xlabel('x')
% ylabel('y')
% zlabel('z')

I1 = zeros(size(IMG3D,3),size(IMG3D,2));
for j = 1:size(IMG3D,1)
    for i = 1:size(IMG3D,3)
        I1(i,:)= IMG3D(j,:,i);
    end
    I_ro1 = imrotate(I1,theta,'bilinear');
    [row,coloum] = size(I_ro1);
    add_row = ceil((size_ro-row)/2);
    add_coloum = ceil((size_ro-coloum)/2);
    for i = 1:row
        pre_result(j,add_coloum:add_coloum+coloum-1,i+add_row) = I_ro1(i,:);
    end    
end
% figure
% clf
% isosurface(pre_result);
% xlabel('x')
% ylabel('y')
% zlabel('z')

len = size(pre_result,2);
width = size(pre_result,3);
hight = size(pre_result,1);
tau = Angle(2);
size_ro = ceil(sqrt(len^2+width^2))+4;
result = zeros(size_ro,size_ro,size_ro);

I2 = zeros(size(pre_result(:,:,1)));
for i = 1:size(pre_result,3)
    I2 = pre_result(:,:,i);
    I_ro2 = imrotate(I2,tau,'bilinear');
    [row,coloum] = size(I_ro2);
    add_row = ceil((size_ro-row)/2);
    add_coloum = ceil((size_ro-coloum)/2);
    result(add_row:add_row+row-1,add_coloum:add_coloum+coloum-1,i)=I_ro2;  
end
% figure
% clf
% isosurface(result);
% xlabel('x')
% ylabel('y')
% zlabel('z')
