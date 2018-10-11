close all;
clear all;
f = 200;         % frequency of signal

fs = 1000;
T = 1/fs;
tmin = 0;
tmax = 1;
t = tmin :T :tmax;

fana = 10000;         % 10kHz sampling frequency for simulating analog signal
Tana = 1/fana;  
tana = tmin:Tana:tmax;
xanalog = fx(tana,f);



%%
%%%% sampled signal spike train
xdt = zeros(1,length(tana));         
for i = 1:length(tana)
    if mod(tana(i),T) == 0   % for t = nT
        xdt(i) = fx(tana(i),f);      %take xdt = x(nT) = x(t)
    end
end
figure(1)
hold on;
stem(tana,xdt,'.');
plot(tana,xanalog);
axis([0 0.01 , -1.5 1.5])
title(['sampled signal spike train']) 
xlabel('Time')  
ylabel('x(nT)')
hold off;




%%
%%%% linear interpolation
ht_li = zeros(1,length(tana));
ht_li(1:11) = 0:fs/fana:1;     % for the first 11 values, it should be increasing values like 0 0.1 0.2 ...1 
ht_li(12:21) = 0.9:-fs/fana:0; % for the next 10 values, it shoud be decreased
figure()
plot(tana,ht_li);


xlt_conv = conv(xdt,ht_li);             % we do the convolution
xlt = xlt_conv(11:length(tana)+10);     % Due to the conv function will give a signal 
                                        % (2N-1) long, and we have shifted the ht from [-T,T] to [0,2T],
                                        % so we should also shift our conv signal and
                                        % cut it to have the same length
% figure()
% plot(xlt_conv);

figure()
hold on;
plot(tana,xlt);
plot(tana,xanalog);
axis([0 0.01 , -1.5 1.5])
title(['linear interpolation']) 
xlabel('Time')  
ylabel('x(nT)')
hold off;


%%
%%%% Ideal Low pass filtering
ht_sinc = zeros(1,length(tana));
t_trunc = -10*T:Tana:10*T;    % we truncate the function in +-10T
hht = sinc(t_trunc ./ T);
ht_sinc(1:length(hht)) = hht;
figure()
plot(tana,ht_sinc);

xrt_conv = conv(xdt,ht_sinc);
xrt = xrt_conv(101:length(tana)+100);

% figure()
% plot(xrt_conv);

figure()
hold on;
plot(tana,xrt);
plot(tana,xanalog);
axis([0 0.05 , -1.5 1.5])
title(['Ideal Low pass filtering']) 
xlabel('Time')  
ylabel('x(nT)')
hold off;


%% Frequency domain view of sampling
%% 3.1
close all;

figure()
subplot(211)
hold on;
plot(tana,xanalog);
axis([0 0.01 , -1 1])
title(['analog signal']) 
xlabel('Time')  
ylabel('x(nT)')
hold off;
subplot(212)
fmagplot(xanalog,Tana);


figure()
subplot(211)
hold on;
stem(tana,xdt,'.');
axis([0 0.01 , -1 1])
title(['sampled signal spike train']) 
xlabel('Time')  
ylabel('x(nT)')
hold off;
subplot(212)
fmagplot(xdt,Tana);


figure()
subplot(211)
hold on;
plot(tana,xlt);
axis([0 0.01 , -1 1])
title(['linear interpolation']) 
xlabel('Time')  
ylabel('x(nT)')
hold off;
subplot(212)
fmagplot(xlt,Tana);


figure()
subplot(211)
hold on;
plot(tana,xrt);
axis([0 0.01 , -1 1])
title(['Ideal low pass filtering']) 
xlabel('Time')  
ylabel('x(nT)')
hold off;
subplot(212)
fmagplot(xrt,Tana);



