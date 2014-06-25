clear
clc
%load('sqim.gif');
PR = imread('sqim.gif');
%% ---------rotaion of the camera--------------------
THETA = -10:180;
N = length(THETA);
for i = 1:N
    I(:,:,i) = PR;
end
%% the line get from the image and form an image only depend on the line---------
for i = 1:size(I,1)
    i;
    for j = 1:N
        IMG(:,j) = I(i,:,j)';
        j;
    end
    %padIMG = padarray(IMG,[10 10],'both');% padding zeros around the iamge
    ReI = iradon(IMG,THETA);
    for k = 1:size(ReI,1)
        ReI3(i,:,k) = ReI(k,:);
    end
end
%% ----------plotting----------------
% figure
% hold
% grid on
% for i = 1:size(ReI3,1)
%     for j = 1:size(ReI3,2)
%         for k = 1:size(ReI3,3)
%             if ReI3(i,j,k)>0.01
%                 plot3(i,j,k,'*');
%             end
%         end
%     end
% end
% axis([0 100 0 100 0 100])
% xlabel('x')
% ylabel('y')
% zlabel('z')
% figure
% imshow(PR)