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
 imafft = fftn(double(ima));

  
 % Now use only the phase
 newfft = imafft./abs(imafft);
 newfft_2 = abs(imafft);
 
 ima_out = ifft2(newfft);
 ima_out_2 = ifft2(newfft_2);
 
 figure();
 subplot(121);
 imagesc(abs(ima_out));
 axis image;
 title('Phase only version');
 subplot(122);
 imagesc(abs(ima_out_2));
 axis image;
 title('Amplitude only version');
 
end
