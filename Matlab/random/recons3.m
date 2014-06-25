clear
clc
load('PR.mat');
test = ones(4,4);
IMG = test;
%% ---------rotaion of the camera--------------------
THETA = 1:180;
%% -------------- padding edge-----------------------
padIMG = padarray(IMG,[10 10],'both');
%% -------------cubic constrcution-------------------
n = max(size(padIMG));
cubic = zeros(size(padIMG,1),size(padIMG,2),n);
for i = 1:n
    cubic(:,:,i) = padIMG;
end
%% -------------rotation-----------------------------
Recons3 = zeros(size(cubic));
for i = 1:length(THETA)
    RotateCubic = rotation(cubic,THETA(i));
    Recons3 = Recons3 + RotateCubic;
end

%% 
R_Recons3 = Recons3/n;
%% --------- plotting ----------------
figure
hold
for i = 1:size(R_Recons3,1)
    for j = 1:size(R_Recons3,2)
        for k = 1:size(R_Recons3,3)
            if R_Recons3(i,j,k) >= 0.8
                plot3(i,j,k,'*');
            end
        end
    end
end
xlabel('x')
zlabel('z')
ylabel('y')
axis([1 30 1 30 1 30])