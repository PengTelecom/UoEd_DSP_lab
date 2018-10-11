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

function ima_out = phase_only(ima);

 % Get fourier transform first
 imafft = fftn(single(ima));

  
 % Now use only the phase
 newfft = imafft./abs(imafft);
 
 ima_out = ifft2(newfft);
 
 figure;
 imagesc(abs(ima_out));
 axis image;
 title('Phase only version');
 
