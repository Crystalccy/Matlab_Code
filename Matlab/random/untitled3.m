
clf;
img_gray=tranIMG_noise;
img_erzhi=tranIMG_noise;
imshow(img_gray)
figure,imshow(img_erzhi)
[m n]=size(img_gray);
img_gray_fu=zeros(m,n);
img_gray_peng=zeros(m,n);
img_erzhi_fu=zeros(m,n);
img_erzhi_peng=zeros(m,n);

for i=2:m-1
    for j=2:n-1
        img_gray_fu(i,j)=min(min(img_gray(i-1:i+1,j-1:j+1)));
        img_gray_peng(i,j)=max(max(img_gray(i-1:i+1,j-1:j+1)));
    end
end

figure,imshow((img_gray_fu));
figure,imshow((img_gray_peng));


for i=2:m-1
    for j=2:n-1
        img_erzhi_fu(i,j)=min(min(img_erzhi(i-1:i+1,j-1:j+1)));
        img_erzhi_peng(i,j)=max(max(img_erzhi(i-1:i+1,j-1:j+1)));
    end
end

figure,imshow((img_erzhi_fu));
figure,imshow((img_erzhi_peng));
