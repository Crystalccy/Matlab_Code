function result = makehole(img)
A = zeros(size(img));
A = imnoise(A,'salt & pepper',0.2);
[~,coloum]= size(img);
for i = 1:coloum
    Po = find(A(:,i)==1);
    for j = 1:length(Po)-1
        n = ceil(random('Normal',10,5,1));
        if Po(j+1)-Po(j) < n
            A(Po(j):Po(j+1),i) = 1;
        end
    end
end
A(find(img==0))=0;
result = img;
result(find(A == 1))=0;
