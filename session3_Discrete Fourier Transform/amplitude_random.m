%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%
% This function takes the fft of the input image, gets the phase of the spectrum and
% inverse Fourier transform it back.
%
%       ima_out = phase-only(ima)
%
% Yvan Petillot, December 2001                                
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ima_out = amplitude_random(ima);
imafft = fftn(single(ima));

figure();
subplot(121)
imagesc(abs(ifft2(imafft)));
axis image;
title(' ifft(fft(image))')

% creat random matrix of amplitude
rand_amp =  rand(size(ima));

% Now random the amplitude of image
newfft = imafft .* rand_amp;

ima_out = ifft2(newfft);
 
 subplot(122)
 imagesc(abs(ima_out));
 axis image;
 title(' Random amplitude version');
end