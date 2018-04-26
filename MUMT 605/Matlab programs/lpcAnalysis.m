%   This function computes the error signal E
%   obtained from linear prediction of given
%   input signal x with the number of poles of
%   the prediction filter p.
function [E, a, g] = lpcAnalysis(x,p)
    overlap = 4;
    fftSize = 1024;
    assignin('base','fftSize',fftSize);
    h = floor(fftSize/overlap);
    
    e = zeros(fftSize, floor((size(x,1)/h))+1);
    x = [x; zeros(fftSize,1)]; %zero padding for analysis of the last frame
    E = zeros(size(x));        %output error signal
    a = zeros(size(e,2), p+1); %coefficients of inverse filter
    g = zeros(size(e,2),1);
    
    for i = 1:size(e,2)
        filtBuf = x(((i-1)*h)+1:((i-1)*h)+fftSize);
        R = xcorr(filtBuf.*hanning(fftSize));    %find the autocorrelation of input frame
        R = R(fftSize:end);    %truncate the first half 
        a(i,:) = levinson(R,p);%find coefficients of filter using 
                               %Levinson-Durbin algorithm
        g(i) = sqrt(R(1) + sum(a(i,2:end)'.*R(2:p+1)));
        e(:,i) = (filtBuf - filter([0 -a(i,2:end)], 1, filtBuf))/1;
        E(((i-1)*h)+1:((i-1)*h)+fftSize) ...
            = E(((i-1)*h)+1:((i-1)*h)+fftSize) + e(:,i).*hanning(fftSize);    
    end
end