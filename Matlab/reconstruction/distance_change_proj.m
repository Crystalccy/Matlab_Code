function result = distance_change_proj(IMG,D_cam)
f=30;
result = zeros(size(IMG));
Len = size(IMG,2);
for coloum = 1:Len
    Line = IMG(:,coloum);
    mid = round(length(Line)/2);
    temp_result = zeros(size(Line));
    for i = 1:length(Line)
        pos = f*(i-mid)/(D_cam(coloum))+mid;
        temp_result(round(pos)) = Line(i);
    end
    result(:,coloum) = temp_result;
    clear temp_result;
end
end
