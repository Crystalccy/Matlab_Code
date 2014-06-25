function result = dehole(img)

subplot(2,2,1);
imshow(img);

N = 3;
A = ones(N);
Num = sum(sum(A));
denoise_img = medfilt2(img);

subplot(2,2,2);
imshow(denoise_img);

tempImg = padarray(denoise_img,[N+1,N+1],'both');
Edg = edge(tempImg,'sobel');

subplot(2,2,3);
imshow(Edg)

[row,coloum] = find(Edg == 1);
%[len,height] = size(img);
for k = 1:1
    for i= min(row):max(row)
        for j = min(coloum):max(coloum)
            if (sum(sum((tempImg(i-(N-1)/2:i+(N-1)/2,j-(N-1)/2:j+(N-1)/2)&A)~=0)))
                tempImg(i-(N-1)/2:i+(N-1)/2,j-(N-1)/2:j+(N-1)/2) = 1;
            end
        end
    end
end
for k = 1:1
    for i= min(row):max(row)
        for j = min(coloum):max(coloum)
            if (sum(sum((tempImg(i-(N-1)/2:i+(N-1)/2,j-(N-1)/2:j+(N-1)/2)&A)~=Num/2)))
                tempImg(i-(N-1)/2:i+(N-1)/2,j-(N-1)/2:j+(N-1)/2) = 0;
            end
        end
    end
end
result = tempImg(N+2:end-N+1,N+2:end-N+1);
subplot(2,2,4);
imshow(result);