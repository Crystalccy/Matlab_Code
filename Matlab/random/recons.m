clear
clc
%% ---------rotaion of the camera--------------------
THETA = -45:10:45;

%% the line get from the image and form an image only depend on the line---------
I = ([zeros(1,10),ones(1,180),zeros(1,10)]);
%I = ([zeros(1,10),0.5*sin(0:180)+0.5,zeros(1,10)]);
IMG = zeros(length(I),length(I));

for i = 1:length(I)
    IMG (:,i) = I(i);
end
Pad = ceil((ceil(sqrt(size(IMG,1)^2+size(IMG,2)^2))-max(size(IMG)))/2);
padIMG = padarray(IMG,[Pad Pad],'both');% padding zeros around the iamge
n1 = size(padIMG,1);
x = linspace(-1,1,n1);
%% ---------------rotation preperation---------------
[X1,Y1] = meshgrid(x,x);

n = length(THETA);
PR = zeros(size(padIMG));
%% ----------------reconstruction-----------------------
for i = 1:n
    for j = 1:length(I)
        IMG (:,j) = I(j);
    end
    padIMG = padarray(IMG,[Pad Pad],'both');
    theta = (90-THETA(i))*pi/180;
    X = cos(theta)*X1 + -sin(theta)*Y1;
    Y = sin(theta)*X1 + cos(theta)*Y1;
    % interpolate
    tmpimg = interp2(X1,Y1,padIMG,X,Y);
    tmpimg(isnan(tmpimg)) = 0;
    % sum
    PR = PR + tmpimg;
end
PR = PR/n;

%PR(find(PR<0.59))= 0;
%% -------------------- plotting----------------------------
imshow((PR));