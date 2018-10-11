close all;
clear all;

%% Section A
%%% 4
a = 3 + 5j;
b = 2 + 11j;

a+b
a-b
a*b
a/b

x = 0:0.2:20
y = ones(size(x))


%%% 5
f = 100;   % frequency is 100Hz    >>
t = 0:1/(20*f):1/f; % a time vector to cover 1 period of         
                    % the wave with 20 points calculated  >>
x = sin(2*pi*f*t); % the sinewave signal  

figure(1)
hold on
title('x=sin(2pift)')
xlabel('t')
ylabel('x')
grid on
plot(t,x);  %add a plot command here 
hold off

%%% 6
im1 = imread('peppers.png');
im2 = randn(384,512);

figure(1) 
imshow(im1); % Display matrices as images 
figure(2) 
imshow(im2); 

figure(3)
subplot(3,1,1)
imshow(im1(:,:,1))
title('Red Component');
subplot(3,1,2)
imshow(im1(:,:,2))
title('Green Component');
subplot(3,1,3)
imshow(im1(:,:,3))
title('Blue Component');

figure(4)
im1 = im2double(rgb2gray(im1)); 
ima = im1 + 0.1*im2;
imshow(ima)




