clear all;
close all;
clc;

img=imread('lena.bmp');
img=img>128;
img=mat2gray(img);
imshow(img);

[m n]=size(img);
[x y]=ginput();
x=round(x);
y=round(y);

tmp=ones(m,n);
queue_head=1;       %队列头
queue_tail=1;       %队列尾
neighbour=[-1 -1;-1 0;-1 1;0 -1;0 1;1 -1;1 0;1 1];  %和当前像素坐标相加得到八个邻域坐标
%neighbour=[-1 0;1 0;0 1;0 -1];     %四邻域用的
q{queue_tail}=[y x];
queue_tail=queue_tail+1;
[ser1 ser2]=size(neighbour);

while queue_head~=queue_tail
    pix=q{queue_head};
    for i=1:ser1
        pix1=pix+neighbour(i,:);
        if pix1(1)>=1 && pix1(2)>=1 &&pix1(1)<=m && pix1(2)<=n
            if img(pix1(1),pix1(2))==1 
                img(pix1(1),pix1(2))=0;
                q{queue_tail}=[pix1(1) pix1(2)];
                queue_tail=queue_tail+1;

            end      
        end
    end

    queue_head=queue_head+1;
end

figure(1);
imshow(mat2gray(img));