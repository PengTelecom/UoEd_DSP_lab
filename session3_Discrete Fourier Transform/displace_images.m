%% displace images
close all;
clear all;
im_1 = imread('./images/lena.jpg');
% do the fft and finde u v which is the number of rows and columns
im_fft = fftn(double(im_1));
[u,v]=size(im_fft);
N = max(u,v); % if the image is square, then N = u = v

% x0 y0 are the value we want to shift  
x0 = 100; 
y0 = 250;

% creat the matrix of extra phase 
vector_u = x0 * [1:u]';
vector_v = y0 * [1:v];

M = zeros(u,v);
for m = 1:u
    for n = 1:v
        M(m,n) = vector_u(m) + vector_v(n);
    end
end

M_phase = exp(-j*2*pi*M ./N);

new_fft = im_fft .* M_phase;

im_shifted = abs(ifft2(new_fft));

figure()
imshow(uint8(im_shifted))