close all;
clear all;

%% Signal Generation & Sampling
%% 1.1
N = 64;           % 64 data points
fs = 1000;         % 1kHz sampling frequency 
T = 1/fs;          % sample period 
f = 40;           % signal frequency in Hz 
n = 0:N-1;      % discrete time vector 
 
x = cos(2*pi*f*n*T);
stem(n*T,x); 
title('stem 40Hz cosine') 
xlabel('Time')  
ylabel('x(nT)')

%% 1.2
plot(n*T,x);
title('plot 40Hz cosine') 
xlabel('Time')  
ylabel('x(nT)')

%% 1.3
close all;
clear all;

fs = 1000;         % 1kHz sampling frequency 
T = 1/fs;  
tmin = 0;
tmax = 1;

t = tmin :T :tmax;
farray= [200,400,600,800];
for i=1:4
    f = farray(i);
    x = cos(2*pi*f*t);
    figure(i)
    hold on;
    stem(t,x); 
    plot(t,x);
    tmin = 0;
    tmax = 0.01;
    axis([tmin 0.01 , -1 1])
    title([num2str(f),'Hz cosine with fs=',num2str(fs),'Hz']) 
    xlabel('Time')  
    ylabel('x(nT)')
    hold off;
end

%% 1.4  
close all;
clear all;

fs = 10000;         % 10kHz sampling frequency 
T = 1/fs;  
tmin = 0;
tmax = 1;
t = tmin :T :tmax;

farray= [200,400,600,800];
for i=1:4
    f = farray(i);
    x1000 = cos(2*pi*f*t*10);
    x10000 = cos(2*pi*f*t);

    figure(i)
    hold on;
    plot(10*t,x1000,'b');
    plot(t,x10000,'r');
    axis([0 0.01 , -1 1])
    title([num2str(f),'Hz cosine']) 
    xlabel('Time')  
    ylabel('x(nT)')
    legend('fs=1000','fs=10000')
    hold off;
    
%     soundsc(interp(x1000,8),8*fs/10);
%     soundsc(interp(x10000,8),8*fs);
end

%% Reconstruction filters 
%% 2.1
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
axis([0 0.01 , -1 1])
title(['sampled signal spike train']) 
xlabel('Time')  
ylabel('x(nT)')
hold off;


%%%% linear interpolation
xlt = zeros(1,length(tana));
for i = 1:length(tana)
    n = floor(tana(i)./T-1):1:floor(tana(i)./T+ 1);         %reduce the -inf_+inf to limited value
    ht = (T-abs(tana(i)-n*T))./T;           % calculate the vector of h(t-nT) for reduced vector x(tn)
    ht(ht<0) = 0 ;
    for j = 1:length(n)
        xlt(i) = xlt(i) + fx(n(j)*T,f)*ht(j);       %cumulate the x(tn)h(t-nT)
    end
end
figure(3)
hold on;
plot(tana,xlt);
plot(tana,xanalog);
axis([0 0.01 , -1 1])
title(['linear interpolation']) 
xlabel('Time')  
ylabel('x(nT)')
hold off;



%%%% Ideal Low pass filtering
xrt = zeros(1,length(tana));
n = (tmax-tmin)*fs;      %calculate the possible n based on the length of time and sampling frequency
for i = 1:length(tana)
    for j = 0:n+1
        xrt(i) = xrt(i) + fx(j*T,f)*sinc((tana(i)-j*T)./T);
    end
end

figure(4)
hold on;
plot(tana,xrt);
plot(tana,xanalog);
axis([0 0.01 , -1.5 1.5])
title(['Ideal Low pass filtering']) 
xlabel('Time')  
ylabel('x(nT)')
hold off;

% 
% soundsc(interp(xdt,8),8*fs)
% soundsc(interp(xlt,8),8*fs)
% soundsc(interp(xrt,8),8*fs)
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


