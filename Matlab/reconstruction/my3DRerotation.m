function result = my3DRerotation(IMG3D,Angle)
len = size(IMG3D,2);
width = size(IMG3D,3);
hight = size(IMG3D,1);
theta = Angle(1);%*pi/180;
tau = Angle(2);
size_ro = ceil(sqrt(len^2+width^2))+4;

% add_width = ceil((size_ro-width)/2);
% add_len = ceil((size_ro-len)/2);
% add_hight = ceil((size_ro-hight)/2);
% 
pre_result = zeros(size_ro,size_ro,size_ro);

% figure;
% clf;
% isosurface(IMG3D);
% xlabel('x')
% ylabel('y')
% zlabel('z')

for i = 1:size(IMG3D,3)
    I2 = IMG3D(:,:,i);
    I_ro2 = imrotate(I2,tau,'bilinear');
    [row,coloum] = size(I_ro2);
    add_row = ceil((size_ro-row)/2);
    add_coloum = ceil((size_ro-coloum)/2);
    pre_result(1+add_row:add_row+row,1+add_coloum:add_coloum+coloum,i)=I_ro2;
end
% figure
% clf
% isosurface(result);
% xlabel('x')
% ylabel('y')
% zlabel('z')


len = size(pre_result,2);
width = size(pre_result,3);
hight = size(pre_result,1);

size_ro = ceil(sqrt(len^2+width^2))+4;
result = zeros(size_ro,size_ro,size_ro);

I1 = zeros(size(pre_result,3),size(pre_result,2));
for j = 1:size(pre_result,1)
    for i = 1:size(pre_result,3)
        I1(i,:)= pre_result(j,:,i);
    end
    I_ro1 = imrotate(I1,theta,'bilinear');
    [row,coloum] = size(I_ro1);
    add_row = ceil((size_ro-row)/2);
    add_coloum = ceil((size_ro-coloum)/2);
    for i = 1:row
        result(j,1+add_coloum:add_coloum+coloum,i+add_row) = I_ro1(i,:);
    end    
end
% figure
% clf
% isosurface(pre_result);
% xlabel('x')
% ylabel('y')
% zlabel('z')

