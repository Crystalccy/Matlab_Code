function result = distance_change_recon(IMG,D_cam)
f = 30;

%Filtered_img = myfilter(IMG,size(IMG,1));
len1 = size(IMG,1);
Len = len1;
result = zeros(size(IMG));
mid = ceil(Len/2);
coloum = size(IMG,2);
for i = 1:coloum
    Line = IMG(:,i);
    Pos = find(Line~=0);
    Px = ceil((Pos-mid)*(D_cam(i)-1)/f+mid);
    P = find((Px)>0 & (Px)<Len);
    high = max(P);
    low = min(P);
    A = zeros(size(IMG));
    A(Px(P)) = Line(Pos(P));
    A1 = A(Px(low):Px(high));
    B = A1; B(find(B==0))=[];
    len = (length(A1)*length(B));
    if length(B) > 1
        inter = 1/length(A1);
        intered_line = interp1(B,1:inter:length(B),'pchip');
        subinter = len/length(A1)-1;
        result_line = intered_line(1:subinter:end);
        result(Px(low):Px(high),i)=result_line(1:length(A1));
    end
end






