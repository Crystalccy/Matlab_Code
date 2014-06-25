clear
clc
%% ---improting original image------- 
% IMG = phantom(128);

IMG = double(imread('sqim.gif'));

% x = [63 186 54 190 63];
% y = [60 60 209 204 60];
% IMG = poly2mask(x,y,256,256);
% 
Theta = 0:180;

%% ---- projection part --------------
tranIMG_inter = uint8(Intergrating(IMG,Theta)); % intergating
tranIMG_norm = NormalProjection(IMG,Theta); % normal projection

%% ---- adding holes -----------------
ImgHole_inter = (makehole(tranIMG_inter));
ImgHole_norm = makehole(tranIMG_norm);

%% ---- adding noise -----------------
tranIMG_noise_inter = imnoise(ImgHole_inter,'salt & pepper',0.05);
tranIMG_noise_inter(find(tranIMG_inter == 0)) = 0;
tranIMG_noise_inter = imnoise(tranIMG_noise_inter,'salt & pepper',0.02);

tranIMG_noise_norm = imnoise(ImgHole_norm,'salt & pepper',0.05);
tranIMG_noise_norm(find(tranIMG_norm == 0)) = 0;
tranIMG_noise_norm = imnoise(tranIMG_noise_norm,'salt & pepper',0.02);

%% ------ denoise and dehole --------------------

de_IMG = dehole1(double(tranIMG_noise_norm),double(tranIMG_noise_inter));

% [thr,sorh,keepapp] = ddencmp('den','wv',tranIMG_noise);
% tranIMG_denoise = wdencmp('gbl',tranIMG_noise,'sym4',2,thr,sorh,keepapp);

%% ---------- filter-------------------
Len = size(de_IMG,1);
Filtered_transIMG = myfilter(de_IMG,Len);

%% ---------reprojection part----------
reconIMG = Myreconstruction(Filtered_transIMG,Theta,Len);
% reconIMG = Myreconstruction(de_IMG,Theta,Len);

%% -----------plotting ----------------
figure;
subplot(2,3,1);
imshow(IMG);
title('original image1');

subplot(2,3,2);
imshow(tranIMG_inter);
% imshow(uint8(tranIMG));
title('transImage1');

subplot(2,3,3);
imshow(tranIMG_noise_inter);
title('noised transImage1');

subplot(2,3,4);
imshow((de_IMG));
title('denoised and deholed transImage1');

subplot(2,3,5);
imshow(reconIMG/max(max(reconIMG)));
title('reconstructed image1');

%% ---------compared normal -----------------------
%% --------- denoise and dehole --------------------

de_IMG = dehole1(double(tranIMG_noise_norm),double(tranIMG_noise_norm));

% [thr,sorh,keepapp] = ddencmp('den','wv',tranIMG_noise);
% tranIMG_denoise = wdencmp('gbl',tranIMG_noise,'sym4',2,thr,sorh,keepapp);

%% ---------- filter-------------------
Len = size(de_IMG,1);
Filtered_transIMG = myfilter(de_IMG,Len);

%% ---------reprojection part----------
reconIMG = Myreconstruction(Filtered_transIMG,Theta,Len);
% reconIMG = Myreconstruction(de_IMG,Theta,Len);

%% -----------plotting ----------------
figure;
subplot(2,3,1);
imshow(IMG);
title('original image2');

subplot(2,3,2);
imshow(tranIMG_norm);
% imshow(uint8(tranIMG));
title('transImage2');

subplot(2,3,3);
imshow(tranIMG_noise_norm);
title('noised transImage2');

subplot(2,3,4);
imshow(double(de_IMG));
title('denoised and deholed transImage2');

subplot(2,3,5);
imshow(reconIMG/max(max(reconIMG)));
title('reconstructed image2');

%% ------------------- compared inter --------------------
%% ------ denoise and dehole --------------------

de_IMG = dehole1(double(tranIMG_noise_inter),double(tranIMG_noise_inter));

% [thr,sorh,keepapp] = ddencmp('den','wv',tranIMG_noise);
% tranIMG_denoise = wdencmp('gbl',tranIMG_noise,'sym4',2,thr,sorh,keepapp);

%% ---------- filter-------------------
Len = size(de_IMG,1);
Filtered_transIMG = myfilter(de_IMG,Len);

%% ---------reprojection part----------
reconIMG = Myreconstruction(Filtered_transIMG,Theta,Len);
% reconIMG = Myreconstruction(de_IMG,Theta,Len);

%% -----------plotting ----------------
figure;
subplot(2,3,1);
imshow(IMG);
title('original image3');

subplot(2,3,2);
imshow(tranIMG_inter);
% imshow(uint8(tranIMG));
title('transImage3');

subplot(2,3,3);
imshow(tranIMG_noise_inter);
title('noised transImage3');

subplot(2,3,4);
imshow((de_IMG));
title('denoised and deholed transImage3');

subplot(2,3,5);
imshow(reconIMG/max(max(reconIMG)));
title('reconstructed image3');