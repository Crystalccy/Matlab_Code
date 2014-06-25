function [tranIMG] = NormalProjection(IMG,Theta)
[Width,Height] = size(IMG);
Diag = ceil(sqrt(Width^2 + Height^2));
Pad_Width = ceil((Diag-Width)/2);
Pad_Height = ceil((Diag-Height)/2);
Pad_IMG = padarray(IMG,[Pad_Width+2,Pad_Height+2],'both');
Len_angle = length(Theta);
tranIMG = zeros(size(Pad_IMG,1),Len_angle);
for i = 1:Len_angle
    Temp_IMG = imrotate(Pad_IMG,-Theta(i),'bilinear','crop');
    temp_tranIMG = sum(Temp_IMG)';
    temp_tranIMG(find(temp_tranIMG ~=0 )) = 1; 
    tranIMG(:,i) = temp_tranIMG;
end