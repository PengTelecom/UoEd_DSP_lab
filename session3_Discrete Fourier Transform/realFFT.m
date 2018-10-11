function XN = realFFT(x)

    N = length(x);
    x_even = x(1:2:end);
    x_odd = x(2:2:end);
        % due to matlab start from 1, but the formula starts from 0, so the
        % x_even is x(1),x(3),x(5)...
        % and the e_odd is the x(2),x(4),x(6)...

    [X_even,X_odd] = dualFFT(x_even,x_odd);
    X_even = [X_even,X_even];
    X_odd = [X_odd,X_odd];
    
    XN = zeros(1,N);
    for k = 1: N  
        XN(k) = X_even(k) + exp(-j*2*pi*(k-1)./N) .* X_odd(k);
    end
    % be careful, in the definition, k is from 0 to N-1, so we need to add
    % change the k to the k-1 in the exp term.

end