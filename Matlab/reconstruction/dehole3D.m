function result = dehole3D(img_norm,img_inter)
denoise_img_norm = medfilt2(img_norm);denoise_img_norm = medfilt2(denoise_img_norm);
denoise_img_inter = medfilt2(img_inter);denoise_img_inter = medfilt2(denoise_img_inter);

denoise_img_inter_mask = denoise_img_inter;
denoise_img_inter_mask(find(denoise_img_inter_mask ~= 0 )) = 1;
PlusImg = denoise_img_inter_mask + denoise_img_norm;
mask1 = [0 1 0;1 1 1;0 1 0];
mask2 = [1 1 1;1 1 1;1 1 1];
PlusIMG_pad = padarray(PlusImg,[1,1],'both');
[row1, coloum1] = size(PlusIMG_pad);
judge = 1;
while judge == 1
    k = 0;
    for i = 2:row1-1
        for j = 2:coloum1-1
            check_block = PlusIMG_pad(i-1:i+1,j-1:j+1);
            check = check_block*mask1;
            if ~isempty(find(check == 2)) && ~isempty(find(check == 1))
                PlusIMG_pad(i,j)=2;
                k = k+1;
            end
        end
    end
    if k ~= 0
        judge = 1;
    else 
        judge = 0;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mask_result = PlusIMG_pad(2:end-1,2:end-1);
mask_result(find(mask_result ~=2 ))=0;

%% dehole
[row,coloum] = size(mask_result);
temp_img = mask_result;
% temp_img(find(temp_img ~= 0))=1;
Edg = uint8(edge(temp_img,'sobel'));
result = double(denoise_img_inter);
high_temp = zeros(1,coloum);
low_temp = zeros(1,coloum);
% smoothing edge
for i = 1:coloum
    if isempty(max(find(Edg(:,i)==1)))
        high_temp(i) = 1;
    else
        high_temp(i) = max(find(Edg(:,i)==1));
    end
    if isempty(min(find(Edg(:,i)==1)))
        low_temp(i) = 1;
    else
        low_temp(i) = min(find(Edg(:,i)==1));
    end
end
high = smooth(1:coloum,high_temp,1,'rloess');
low = smooth(1:coloum,low_temp,1,'rloess');

for i = 1:coloum
%     high = max(find(Edg(:,i)==1));
%     low = min(find(Edg(:,i)==1));
    A = result(low(i):high(i),i);
    B = A; B(find(B==0))=[];
    len = (length(A)*length(B));
    if length(B) > 1
        inter = 1/length(A);
        intered_line = interp1(B,1:inter:length(B),'spline');
        subinter = len/length(A)-1;
        result_line = intered_line(1:subinter:end);
        result(low(i):high(i),i)=result_line(1:length(A));
    end
end
result = uint8(result);
% figure
% imshow(result);

