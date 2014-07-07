clear
clc
%% ---improting original image------- 
 % IMG = phantom(128);

% IMG = double(imread('sqim.gif'));

% x = [63 186 54 190 63];
% y = [60 60 209 204 60];
% IMG = poly2mask(x,y,256,256);
% 

% x = [20,60,60,50,50,60,60,20,20,30,30,20,20];
% y = [20,20,40,40,60,60,80,80,60,60,40,40,20];
% IMG = poly2mask(x,y,100,100);

A = imread('Fenta.jpg');
img = rgb2gray(A);
IMG_temp = imresize(img,[200,200]);
IMG_temp = im2bw(IMG_temp,0.9);
IMG = IMG_temp;
IMG(find(IMG_temp == 1))=0;
IMG(find(IMG_temp == 0))=1;


Theta = 0:180;

%% ---- projection part --------------
tranIMG_inter = uint8((Intergrating(IMG,Theta))); % intergating
tranIMG_norm = NormalProjection(IMG,Theta); % normal projection

%% ---- changing distance--------------
D_cam = random('normal',100,10,1,length(Theta));
D_tranIMG_inter = distance_change_proj(tranIMG_inter,D_cam);
D_tranIMG_norm = distance_change_proj(tranIMG_norm,D_cam);

%% ---- adding holes -----------------
ImgHole_inter = uint8(makehole(D_tranIMG_inter));
ImgHole_norm = makehole(D_tranIMG_norm);



%% ---- adding noise -----------------
tranIMG_noise_inter = imnoise((ImgHole_inter),'salt & pepper',0.05);
tranIMG_noise_inter(find(ImgHole_inter == 0)) = 0;
tranIMG_noise_inter = imnoise(tranIMG_noise_inter,'salt & pepper',0.02);

tranIMG_noise_norm = imnoise(ImgHole_norm,'salt & pepper',0.05);
tranIMG_noise_norm(find(ImgHole_norm == 0)) = 0;
tranIMG_noise_norm = imnoise(tranIMG_noise_norm,'salt & pepper',0.02);


%% -------denoise--------------------------------
denoise_img_norm = medfilt2(tranIMG_noise_norm);denoise_img_norm = medfilt2(denoise_img_norm);
denoise_img_inter = medfilt2(tranIMG_noise_inter);denoise_img_inter = medfilt2(denoise_img_inter);


%% ---re changing distance--------------
D_tranIMG_noise_inter = distance_change_recon(denoise_img_inter,D_cam);
D_tranIMG_noise_norm = distance_change_recon(denoise_img_norm,D_cam);
% D_tranIMG_noise_inter = distance_change_recon(tranIMG_noise_inter,D_cam);
% D_tranIMG_noise_norm = distance_change_recon(tranIMG_noise_norm,D_cam);

%% ------ dehole --------------------

% de_IMG = dehole1(double(tranIMG_noise_norm),double(tranIMG_noise_inter));
de_IMG = dehole3D_prosp(double(D_tranIMG_noise_norm),double(D_tranIMG_noise_inter));

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
imshow((de_IMG/max(max(de_IMG))));
title('denoised and deholed transImage1');

subplot(2,3,5);
imshow(reconIMG/max(max(reconIMG)));
title('reconstructed image1');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       inte           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ------ dehole --------------------

% de_IMG = dehole1(double(tranIMG_noise_norm),double(tranIMG_noise_inter));
de_IMG = dehole3D_prosp(double(D_tranIMG_noise_inter),double(D_tranIMG_noise_inter));

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
imshow((de_IMG/max(max(de_IMG))));
title('denoised and deholed transImage1');

subplot(2,3,5);
imshow(reconIMG/max(max(reconIMG)));
title('reconstructed image1');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       normal           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ------ dehole --------------------

% de_IMG = dehole1(double(tranIMG_noise_norm),double(tranIMG_noise_inter));
de_IMG = dehole3D_prosp(double(D_tranIMG_noise_norm),double(D_tranIMG_noise_norm));

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
imshow((de_IMG/max(max(de_IMG))));
title('denoised and deholed transImage1');

subplot(2,3,5);
imshow(reconIMG/max(max(reconIMG)));
title('reconstructed image1');