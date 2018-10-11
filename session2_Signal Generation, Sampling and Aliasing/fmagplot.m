function fmagplot(xa,dt)
% FMAGPLOT
% fmagplot(xa,dt)
%
% xa: the "analog" signal
% dt: the sampling interval in seconds for the simulated
% analog signal xa
%
L = length(xa);
Nfft = 2.^ceil(log2(L)); % Choose the nearest Power of 2
Xa = fft(xa,Nfft);
range = 0:(Nfft/4); % show frequencies up to 1/4
% sampling rate
ff = range/Nfft/dt/1000; % frequencies in kHz
% plot magnitude frequency
plot(ff,abs(Xa(1+range)))
title('Continuous-time Fourier transform (MAG)');
xlabel('FREQUENCY (kHz)');
grid
