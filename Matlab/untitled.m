A = zeros(65,65,65);
b = ones(31,31,31);
A(18:end-17,18:end-17,18:end-17)= b;
B = zeros(115,115,115);
N = 2*floor(size(B,1)/(2*sqrt(2)));


figure;
clf;
isosurface(A);
theta = 45;
tau = 45;
I1 = zeros(size(A,3),size(A,2));
Len = size(I1,1);
mid = ceil(Len/2);

theta = theta*pi/180;
sinTheta = sin(theta);
cosTheta = cos(theta);

sintau = sin(tau);
costau = cos(tau);

X = (1:N)-ceil(N/2);
x = repmat(X,N,1);
y = rot90(x);

for j = 1:size(A,1)
    for i = 1:size(A,3)
        I1(j,:)= A(j,i,:);
    end
    t = round(x*cosTheta + y*sinTheta);
    I_ro = I1(t+mid);
    for i = 1:size(A,3)
        B()
    end    
end
isosurface()





