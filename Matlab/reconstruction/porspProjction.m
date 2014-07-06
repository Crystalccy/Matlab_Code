function result = porspProjction(IMG,angle,D_cam)
f = 30;
[Width,Height] = size(IMG);
Diag = ceil(sqrt(Width^2 + Height^2));
Pad_Width = ceil((Diag-Width)/2);
Pad_Height = ceil((Diag-Height)/2);
Pad_IMG = padarray(IMG,[Pad_Width+2,Pad_Height+2],'both');
Len_angle = length(angle);
result.trans = zeros(Len_angle,size(Pad_IMG,2));
%result.trans = zeros(size(Pad_IMG,1),size(Pad_IMG,2));
for i = 1:Len_angle
    Temp_IMG = imrotate(Pad_IMG,angle(i),'bilinear','crop');
    Temp_IMG(find(Temp_IMG>0))=1;
    for row = 1:size(Pad_IMG,1) 
        for coloum = 1:size(Pad_IMG,2)
            pos = f*(coloum-1-size(Pad_IMG,2)/2)/(D_cam(i)+row-1)+size(Pad_IMG,2)/2;
            if row == 1
                result.pos(coloum) = pos;
            end
            
            %if rem(pos,1)==0
                %result.trans(row,result.pos(coloum)) = result.trans(row,result.pos(coloum))+Temp_IMG(row,coloum);
                result.trans(i,round(pos)) = result.trans(i,round(pos))+Temp_IMG(row,coloum);
            %end
            
        end
    end
    reuslt.angle(i) = angle(i);
    reuslt.Camey(i) = D_cam(i);
    i
end
result.trans = result.trans';