function result = dehole1(img_norm,img_inter)
%imshow(img);
denoise_img1_norm = medfilt2(img_norm);denoise_img_norm = medfilt2(denoise_img1_norm);
denoise_img1_inter = medfilt2(img_inter);denoise_img_inter = medfilt2(denoise_img1_inter);

[row,coloum] = size(denoise_img_norm);
temp_img = denoise_img_norm;
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

