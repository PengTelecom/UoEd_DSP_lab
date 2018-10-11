%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%
% Image Filtering
%
%       ima_out = SimpleFiltering(ima,type,cutoff)
%
% This function high or low pass filter an image
%     
%       ima : real input image
%       type : 0 for high, 1 for low
%       cutoff: cutoff frequency in [0,1]. 0 is corresponds to the minimum frequency and 1
%					 to the maximum frequency.
%       ima_out : output absolute filtered image
%   
%
% Yvan Petillot, December 2000                                  
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ima_out = SimpleFiltering(ima,type,cutoff)

  % First convert ima to double
  ima = double(ima);
  % Create new figure
  figure(1)
  % Display ima
  imagesc(ima);
  axis image;
  title('Original image');
  pause(0.1);
  drawnow;
  % Get FFT:
  imafft = fftshift(fft2(ima));
  s = size(ima);
  maxr = 0.5*sqrt(s(1)^2+s(2)^2);
  cutoff = maxr*cutoff;
  switch(type)
    % High pass filter
    case 0
      for i = 1 : s(1)
        for j = 1 : s(2)
            r = sqrt((i-1-s(1)/2)^2+(j-1-s(2)/2)^2);
            if ( r < cutoff)
            imafft(i,j) = 0;
            end
        end
      end   
    % Low pass filter
    case 1
      for i = 1 : s(1)
        for j = 1 : s(2)
            r = sqrt((i-1-s(1)/2)^2+(j-1-s(2)/2)^2);
            if ( r > cutoff)
            imafft(i,j) = 0;
            end
        end
      end
  end
  
  % Display filtered spectrum
  figure(2);
  colormap(gray);
  imagesc(log(1+abs(imafft)));
  axis image;
  display('Press any key to proceed');
  pause;
  figure(3);
  colormap(gray);
  ima_out = ifft2(fftshift(imafft));
  %keyboard;
  imagesc(abs(ima_out));
  axis image;
  title('Filtered image');
