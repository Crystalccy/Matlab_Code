function reconIMG = Myreconstruction(Filtered_transIMG,Theta,Len)

N = 2*floor(size(Filtered_transIMG,1)/(2*sqrt(2)));

reconIMG = zeros(N);
mid = ceil(Len/2);

Theta = Theta*pi/180;
sinTheta = sin(Theta);
cosTheta = cos(Theta);

X = (1:N)-ceil(N/2);
x = repmat(X,N,1);
y = rot90(x);

for i=1:length(Theta)
    Line = Filtered_transIMG(:,i);
    t = round(x*cosTheta(i) + y*sinTheta(i));
    reconIMG = reconIMG + Line(t+mid);    
end
reconIMG = reconIMG*pi/(2*length(Theta));
