function result1 = prospRecons(IMG,Angle,D_cam)
f = 20;
pad = D_cam-f;
pad_IMG1 = padarray(IMG,[pad,pad],'both');
pad_IMG = myfilter(pad_IMG1,size(pad_IMG1,2));
len1 = size(IMG,1);
len2 = size(pad_IMG,1);
result = zeros(len2,len2);
temp_result = result;
mid = ceil(len1/2);
for i = 1:length(Angle)
    Line = IMG(:,i);
    Pos = find(Line~=0);
    for row = 1:len2
        Px = ceil((Pos-mid)*(f+row-1)/f+mid);
        P = find((Px+pad)>0 & (Px+pad)<len2);
        % temp_result(row,P)
        temp_result(row,Px(P)+pad) = Line(Pos(P));
    end
    %delaAndero = prosDehole(temp_result);
    %Len = size(delaAndero,1);
    %delaAndero1 = myfilter(delaAndero,Len);

    result = result + imrotate(temp_result,-Angle(i),'bilinear','crop');
    i
end
result1 = result(ceil(len2/2-len1/2):end-ceil(len2/2-len1/2),...
                 ceil(len2/2-len1/2):end-ceil(len2/2-len1/2));
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