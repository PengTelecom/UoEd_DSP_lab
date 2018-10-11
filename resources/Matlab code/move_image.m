%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%
% Move image around by sx sy
%
%       ima_out = move_image(ima,sx,sy)
%
% This function shifts an image using only the phase.
% Following the convolution theorem, convolving a signal
% by a dirac delta(sx) is equivalent to shifting the signal by sx.
% In the fourier plane this is equivalent to multiplying the signal
% by a exponentional (exp(j*2*pi*u*sx/nsx) where nsx is the number of
% pixel in the x dimension and u the frequency. This is equivalent to
% applying a linear phase shift.
%
% Yvan Petillot, December 2000                                  
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ima_out = move_image(ima,sx,sy);
  
  % Get fourier transform first
  imafft = fftn(double(ima));

  % Get Phase and Magnitude
  mag = abs(imafft);
  phi = angle(imafft);
  
  % Now Change phase multiplying by exp(i*2*pi (sx/nsx +sy/nsy))
  s = size(mag);
  nsx = s(1); % nsx can be different of nsy if not square images
  nsy = s(2);
  % Add a linear phase shift -> convolute by a dirac in the image plane
  % which is equivalent to a translation
  for k = 1 : nsx
    for l = 1 : nsy
      newfft(k,l) = mag(k,l)*exp(j*(phi(k,l)-2*pi*((k-1)*sx/nsy+(l-1)*sy/nsy)));
    end
  end
  %linear_phase = -2*coeffs*pi*(sx/nsx +sy/nsy);
  %newfft = mag .* exp(j*(phi + linear_phase));
  ima_out = real(ifft2(newfft));
  
