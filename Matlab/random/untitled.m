clear
clc

load('PR.mat');
THETA = 0:0.5:180;
A = radon(PR,THETA);
B = fft2(PR);















% x = zeros(3,40);
% x = ([zeros(1,10),ones(1,20),zeros(1,10)]);
% x(2,:) = ([zeros(1,10),ones(1,20),zeros(1,10)]);
% x(3,:) = ([zeros(1,10),ones(1,20),zeros(1,10)]);
% figure
% hold
% grid on
% %# Number of rows is a multiple of number of columns
% x = 1:10;
% y = 1:50;
% for i = 1:10
%     
%     for j = 1:50
%         A = x(i)+y(j)*tan(45);
%         B = y(j);
%         plot(A,B,'*');
%        
%     end
% end
% axis([0 100 0 100]);
% 


%%
% iptsetpref('ImshowAxesVisible','on')
% I = zeros(100,100);
% I(25:75, 25:75) = 1;
% theta = 0:90;
% [R,xp] = radon(I,theta);
% imshow(R,[],'Xdata',theta,'Ydata',xp,...
%             'InitialMagnification','fit')
% xlabel('\theta (degrees)')
% ylabel('x''')
% colormap(hot), colorbar
% iptsetpref('ImshowAxesVisible','off')
% figure
% imshow(I)
% 
% [r,xpp] = radon(I,0);
% figure;
% plot(r);
% 
% 
% 
% [rr,xppp] = radon(r,0);
% figure;
% plot(rr);
