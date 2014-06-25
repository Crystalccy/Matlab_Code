function result = rotation(I,THETA)
result = zeros(size(I));
[x] = linspace(-1,1,(size(I,3)));
[X1,Y1] = meshgrid(x,x);

theta = (90-THETA)*pi/180;
    X = cos(theta)*X1 + -sin(theta)*Y1;
    Y = sin(theta)*X1 + cos(theta)*Y1;
for i = 1:size(I,1)
    img = zeros(size(I,2),size(I,3));
    img_temp = I(i,:,:);
    img(:) = img_temp;  
    % interpolate
    tmpimg = interp2(X1,Y1,img,X,Y);
    tmpimg(isnan(tmpimg)) = 0;
    for j = 1:size(tmpimg)
        result(i,:,j) = tmpimg(j,:);
    end
end