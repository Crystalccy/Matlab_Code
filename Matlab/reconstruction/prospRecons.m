function result = prospRecons(IMG,Angle,D_cam)
f = 20;
pad = max(D_cam)-f;
%Filtered_img = myfilter(IMG,size(IMG,1));
len1 = size(IMG,1);
Len = len1+pad*2;
result = zeros(Len,Len);
mid = ceil(Len/2);
pad_IMG1 = padarray(IMG,[pad,pad],'both');
pad_IMG = pad_IMG1(:,pad+1:end-pad);
for i = 1:length(Angle)
    temp_result = zeros(Len,Len);
    Line = pad_IMG(:,i);
    %imshow(Line);
    Pos = find(Line~=0);
    diff = max(D_cam)-D_cam(i);
    for row = (1+diff):(Len-diff)
        Px = ceil((Pos-mid)*(f+row-1)/f+mid);
        P = find((Px)>0 & (Px)<Len);
        % temp_result(row,P)
        temp_result(row,Px(P)) = Line(Pos(P));
    end
    %delaAndero = prosDehole(temp_result);
    %Len = size(delaAndero,1);
    %delaAndero1 = myfilter(delaAndero,Len);
    rotate =  imrotate(temp_result,-Angle(i),'bilinear','crop');
    %imshow(temp_result/max(max(temp_result)));
    result = result + rotate;
    i
end
result = result/(2*length(Angle));
%result1 = result(ceil(len2/2-len1/2):end-ceil(len2/2-len1/2),...
%                 ceil(len2/2-len1/2):end-ceil(len2/2-len1/2));
end

function result = prosDehole(IMG1)
PlusIMG_pad = padarray(IMG1,[10,10],'both');
[row1, coloum1] = size(PlusIMG_pad);
dela = delation(PlusIMG_pad,row1,coloum1);
ero = erosion(dela,row1,coloum1);
result = ero(11:end-10,11:end-10);
end

%%  delation
function result = delation(img1,row1,coloum1)
result_pad = zeros(size(img1));
img1_temp = img1;
time = 5;
mask1 = [0 1 0;1 1 1;0 1 0];
while time ~= 0
    for i = 2:row1-1
        for j = 2:coloum1-1
            check_block = img1(i-1:i+1,j-1:j+1);
            check = check_block.*mask1;
            if  sum(sum(check))~=0
                img1_temp(i,j)=2;
                temp_block = result_pad(i-1:i+1,j-1:j+1);
                result_pad(i,j) = sum(sum(temp_block))/sum(sum(temp_block~=0));
            end
        end
    end
    img1 = img1_temp;
    time = time-1;
end
result = img1;
end

%% erosion
function result = erosion(img2,row1,coloum1)
result_pad = zeros(size(img2));
mask1 = [0 1 0;1 1 1;0 1 0];
img2_temp = img2;
time = 5;
while time ~= 0
    for i = 2:row1-1
        for j = 2:coloum1-1
            check_block = img2(i-1:i+1,j-1:j+1);
            check = check_block.*mask1;
            if  (check(1,2)==0 ||check(2,1)==0||check(2,2)==0||check(2,3)==0||check(3,2)==0)
                img2_temp(i,j)=0;
                temp_block = result_pad(i-1:i+1,j-1:j+1);
                result_pad(i,j) = 0;
            end
        end
    end
    time = time-1;
    img2 = img2_temp;
end
result = img2;
end