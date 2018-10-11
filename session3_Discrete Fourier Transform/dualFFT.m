function [X, Y] = dualFFT(x,y)
    v = x + j*y;
    V = fft(v);
    V_star = zeros(1,length(V));
    % V_star(1) = V(1); %%%V_star(1)
    V_star(2:end)=conj(fliplr(V(2:end)));
    X = (V + V_star)./2;
    Y = (V - V_star)./(2*j);
    
    % due to we dont have V_star(N) to compare VN(0), so we need to add it.
    V_star_N = conj(V(1));
    X(1) = (V(1)+ V_star_N)/2;
    Y(1) = (V(1)- V_star_N)/(2*j);
    
end












