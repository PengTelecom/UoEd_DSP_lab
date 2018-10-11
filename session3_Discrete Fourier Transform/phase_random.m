%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%
% This function takes the fft of the input image, gets the phase of the spectrum and
% inverse Fourier transform it back.
%
%       ima_out = phase-random(ima)
%
% Yvan Petillot, December 2001                                
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ima_out = phase_random(ima);
imafft = fftn(single(ima));

figure();
subplot(121)
imagesc(abs(ifft2(imafft)));
axis image;
title(' ifft(fft(image))')

% create random matrix of phase
rand_phase = exp(j * rand(size(imafft))*2*pi);

% Now random the phase of image
newfft = imafft .* rand_phase;
 
ima_out = ifft2(newfft);

subplot(122)
imagesc(abs(ima_out));
axis image;
title(' Random phase version');
end
 
