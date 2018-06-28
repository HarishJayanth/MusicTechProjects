function y = timeScale(x, alpha)
%ihop = input hop size
%ohop = output hop size
%alpha = time scaling factor

    fftSize = 1024;
    overlap = 16;
    ohop = fftSize / overlap;
    ihop = floor(ohop / alpha);
    
    imax = floor(size(x,1) / ihop);
    zpad = fftSize - size(x,1) + (imax)*ihop;
    x = [zeros(ohop,1);x; zeros(zpad,1)];
    y = zeros((imax-1)*ohop + fftSize,1);
    t = ohop + 1;
    Xt = fft(x(t:t+fftSize-1));
    Ymag = abs(Xt);
    Yang = angle(Xt);
    y(1:fftSize) = x(t:t+fftSize-1).*hanning(fftSize);
    for i = 2:imax
        t = t + ihop;
        xt = x(t:t+fftSize-1).*hanning(fftSize);
        Xt = fft(xt, fftSize);
        s = t - ohop;
        xs = x(s:s+fftSize-1).*hanning(fftSize);
        Xs = fft(xs, fftSize);
        phDiff = unwrap(angle(Xt)) - unwrap(angle(Xs));
        Yang = Yang + phDiff;
        
        Ymag = abs(Xt);
        Y = Ymag .* exp(1i*Yang);
        u = (i-1)*ohop+1;
        y(u:u+fftSize-1) = y(u:u+fftSize-1) + ifft(Y,fftSize).*hanning(fftSize);
    end
     y = real(y)/5.208;
end

