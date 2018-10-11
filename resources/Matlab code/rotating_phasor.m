%	MATLAB Rotating Phasor Animation
%
%	using basic MATLAB drawing functions

clear

% 4 cycles of constant amplitude 4Hz phasor

M = 128;                    % no of samples
step = 360/M;               % angular step (degrees)
f = 4;                      % fequency (Hz)
dt = 1/M;                   % time step (seconds)
ph = 0;                     % initial phase shift
t = 0:dt:1;                 % time axis
A = 1;                      % initial amplitude
x = exp(j*2*pi*f*t);		%unit amplitude phasor
xr = real(x);               %Real part
xi = imag(x);               %Imaginary part
xmax = max([xr xi ])*1.1;	%sets amplitude axes > max plot size
tmin = min(t);              %sets t axis min = start value
tmax = max(t);              %sets t axis max = stop value


fprintf(1,'Rotating Phasor: press return to start\n')
pause;

figure(1);                          % make figure appear

for ii =1:M+1,

%	timer
t0 = clock;
te = 0;

%	phasor plot

subplot(2,2,1)                      %plot phasor on previously set axes
plot(xr(1:ii),xi(1:ii),'y');        % plot phasor trajectory
hold on
plot([0,xr(ii)],[0,xi(ii)],'o-k');    % plot radial line for current phasor

plot([xr(ii),xmax],[xi(ii),xi(ii)],'g') % plot horizontal line indicating current value of xi
plot([xr(ii),xr(ii)],[-xmax,xi(ii)],'b') % plot vertical line indicating current value of xi
axis( [ -xmax xmax -xmax xmax ]);
axis('square');
title('phasor');
xlabel('real part');
ylabel('imag part');
hold off

drawnow

%	Imag signal plot

subplot(2,2,2)                          %plot sinusoid on previously set axes
plot(t(1:ii),xi(1:ii),'r');             % plot imaginary component against time
hold on;
plot([t(1),t(ii)],[xi(ii),xi(ii)],'g') % plot horizontal line indicating current value of xi
hold off
axis( [ tmin tmax -xmax xmax ]);
axis('square')
xlabel('time');
ylabel('imag part');
title('signal');

drawnow

%	Real signal plot

%%%%%%%%%%%%%%%%%%
% ADD CODE HERE  %
%%%%%%%%%%%%%%%%%%


%	constant frame rate via a busy wait loop

while te < 0.2
	te = (clock - t0) * [0 0 86400 3600 60 1]';
end

end
