close all;
clear all;
x_tri = triangle(30,30);
xf_tri = fft(x_tri);
figure()
plot(x_tri)
% N = length(x_tri);
% XN = zeros(1,N/2);
% for k = 1:N/2
%     DFTeven = 0;
%     DFTodd = 0;
%     for n2 = 1 : N/2
%         DFTeven =DFTeven + x_tri(2*n2-1) * exp(-j*2*pi*k*n2 ./(N/2));
%         DFTodd =DFTodd +  x_tri(2*n2)* exp(-j*2*pi*k*n2 ./(N/2));
%     end
%     XN(k) = DFTeven + exp(-j*2*pi*k./N)* DFTodd;
% end

%%% methode of using matrix
N = length(x_tri);
XN = zeros(1,N/2);
% creat a matrice of k*n2
k = 1:1:50;
n2 = 2:2:100;
k_n2 = k' * n2;
matrix = exp(-j*2*pi*k_n2/(N/2));
% do the DFT
x_even = x_tri(2:2:end);
DFTeven = x_even * matrix;
x_odd = x_tri(1:2:end);
DFTodd = x_odd * matrix;
XN = DFTeven + DFTodd .* exp(-j*2*pi*k/N);
xodd = abs(ifft(DFTodd));
xeven = abs(ifft(DFTeven));


figure()
subplot(211)
plot(x_odd)
subplot(212)
plot(xodd)
figure()
subplot(211)
plot(x_even)
subplot(212)
plot(xeven)