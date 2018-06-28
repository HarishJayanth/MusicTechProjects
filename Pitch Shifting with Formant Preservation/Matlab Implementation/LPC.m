%   This function computes the error signal E
%   obtained from linear prediction of given
%   input signal x with the number of poles of
%   the prediction filter p.
function E = lpcAnalysis(x,p)

    
    overlap = 4;
    fftSize = 1024;
    h = floor(fftSize/overlap);
    
    e = zeros(fftSize, floor((size(x,1)/h))+1);
    x = [x; zeros(fftSize,1)]; %zero padding for analysis of the last frame
    E = zeros(size(x));        %output error signal
    a = zeros(size(e,2), p+1); %coefficients of inverse filter
        
    for i = 1:size(e,2)
        filtBuf = x(((i-1)*h)+1:((i-1)*h)+fftSize);
        R = xcorr(filtBuf);    %find the autocorrelation of input frame
        R = R(fftSize:end);    %truncate the first half 
        a(i,:) = levinson(R,p);%find coefficients of filter using 
                               %Levinson-Durbin algorithm
        e(:,i) = filtBuf - filter([0 -a(i,2:end)], 1, filtBuf);
        E(((i-1)*h)+1:((i-1)*h)+fftSize) ...
            = E(((i-1)*h)+1:((i-1)*h)+fftSize) + e(:,i).*hanning(1024);    
    end
end

%   This function computes the output of the synthesis filter
%   for a given excitation source signal and a given signal 
%   and time varying response of synthesis filter.
function y = lpcSynthesis(E, a)
    y = zeros(size(E));
    for i = 1:size(a,1)
        filtBuf = E(((i-1)*h)+1:((i-1)*h)+fftSize);
        filtOut = filter(1, a(i,:), filtBuf);
        y(((i-1)*h)+1:((i-1)*h)+fftSize) ...
            = y(((i-1)*h)+1:((i-1)*h)+fftSize) + filtOut.*hanning(fftSize);    
    end
end

overlap = 4;
fftSize = 1024;
h = floor(fftSize/overlap);

e = zeros(fftSize, floor((size(x,1)/h))+1);
x = [x; zeros(fftSize,1)];
xd = [zeros(d,1);x; zeros(h,1)];
E = zeros(size(x));
y = zeros(size(x));
A = zeros(size(x));
a = zeros(size(e,2), p+1);
a1 = zeros(size(e,2), p+1);
imp = [1; zeros(fftSize-1,1)];
for i = 1:size(e,2)
    filtBuf = x(((i-1)*h)+1:((i-1)*h)+fftSize);
    delayBuf = xd(((i-1)*h)+1:((i-1)*h)+fftSize);
    R = xcorr(filtBuf,delayBuf);
    R = R(fftSize:end);
    a(i,:) = levinson(R,p);
    %[a1(i,:),g(i,:)] = lpc(filtBuf, p);
    e(:,i) = filtBuf - filter([0 -a(i,2:end)], 1, filtBuf);
    E(((i-1)*h)+1:((i-1)*h)+fftSize) = E(((i-1)*h)+1:((i-1)*h)+fftSize) + e(:,i).*hanning(1024); ;    
end

E1 = timeScale(E, 0.5);
E1 = resample(E1,10,5);
E1 = E1(1:size(x,1));

for i = 1:size(e,2)
    filtBuf = E1(((i-1)*h)+1:((i-1)*h)+fftSize);
    e(:, i) = filter(1, a(i,:), filtBuf);
    A(((i-1)*h)+1:((i-1)*h)+fftSize) = filter(1, a(i,:), imp);
    y(((i-1)*h)+1:((i-1)*h)+fftSize) = y(((i-1)*h)+1:((i-1)*h)+fftSize) + e(:,i).*hanning(1024);    
end

subplot(4,1,1);
plot(x);
subplot(4,1,2);
plot(E1);
subplot(4,1,3);
plot(y);
subplot(4,1,4);
plot(A);
