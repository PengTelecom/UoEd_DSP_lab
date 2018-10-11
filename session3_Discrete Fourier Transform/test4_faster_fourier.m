
%%
close all;
clear all;
x = triangle(30,60);
X_0 = fft(x);

N = length(x);
for i = 1:N/2
    x_even(i) = x(2*i-1);
    x_odd(i) = x(2*i);  
        % due to matlab start from 1, but the formula starts from 0, so we need to even is 2i-1 in matlab
end

[X_even,X_odd] = dualFFT(x_even,x_odd);
figure()
hold on;
plot(real(X_0))
plot(real(X_even))
hold off;

figure()
hold on;
plot(imag(X_0))
plot(imag(X_even))
hold off;

figure()
hold on;
plot(real(X_0))
plot(real(X_odd))
hold off;

figure()
hold on;
plot(imag(X_0))
plot(imag(X_odd))
hold off;

%%
figure()
hold on;
plot(real(ifft(X_odd)))
%plot(real(ifft(X_even)))
plot(x_odd)
hold off

%%
XN = zeros(1,N);
for k = 1: 50   
    XN(k) = X_even(k) + exp(-j*2*pi*k./N) .* X_odd(k);
end
XN(52:100) = conj(fliplr(XN(2:50)));
figure()
hold on;
plot([0:99],X_0);
plot([0:99],XN);
legend('original signal','fster DFT version');
hold off;

figure();
subplot(311)
plot(abs(XN-X_0));
subplot(312)
plot(real(XN-X_0));
subplot(313)
plot(imag(XN-X_0));

XN(1) = XN(1)+18;
figure();
hold on;
plot(x);
plot(real(ifft(XN)));
legend('original signal','fster DFT version');
hold off;