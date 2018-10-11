%Simple low pass filters


fmean3 = ones(3,3);


fmean5 = ones(5,5);


fmean11 = ones(11,11);


%Better ones


fgaussian5_1 = fspecial('gaussian',5,1);


fgaussian7_05 = fspecial('gaussian',7,0.5);


fgaussian7_3 = fspecial('gaussian',7,3);





%Simple edge detectors


fsobelx = fspecial('sobel');


fprewittx = fspecial('prewitt');


%More advanced ones


flog = fspecial('log',5,1);


%Top of the pop : use FIR filters


b = remez(10,[0 0.05 0.15 0.55 0.65 1],[0 0 1 1 0 0]);


ftop = ftrans2(b);


