%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%
% Image Filtering
%
%       ima_out = Analyse_Filter(ima,h)
%
% This function high or low pass filter an image
%     
%       ima : real input image
%       h   : filter in space domain
%   
%
% Yvan Petillot, January 2002                                  
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ima_out = Analyse_Filter(ima,h)

% Show original image

figure(1);

subplot(1,3,1);

%ima = histeq(ima);

imshow(ima);

xlabel('Original image');

drawnow;

ima = double(ima);

% Filter size generation

sx = size(h,1); 

sy = size(h,2);

% Compute fft and show result

H = zeros(256,256);

H(128-floor(sx/2):128+floor(sx/2),128-floor(sy/2):128+floor(sy/2)) = h;

FH = fftshift(fft2(fftshift(H)));

subplot(1,3,2);

imshow(log(abs(FH)+1));

xlabel('FFT magnitude display');

drawnow;

figure(2);

freqz2(h);

xlabel('Frequency response in 3D');

drawnow;

% Filter Image

figure(1);

ima_out = filter2(h,ima);

mini = min(min(ima_out));

maxi = max(max(ima_out));

ima_out = (ima_out-mini)/(maxi-mini);

subplot(1,3,3);

imshow(ima_out);

xlabel('Resulting filtered image');

drawnow;