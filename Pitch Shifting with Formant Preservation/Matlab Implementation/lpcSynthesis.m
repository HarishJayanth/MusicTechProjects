%   This function computes the output of the synthesis filter
%   for a given excitation source signal and a given signal 
%   and time varying response of synthesis filter.
function y = lpcSynthesis(E, a, g)
    overlap = 4;
    fftSize = 1024;
    h = floor(fftSize/overlap);

    y = zeros(size(E));
    for i = 1:size(a,1)
        filtBuf = E(((i-1)*h)+1:((i-1)*h)+fftSize); %frame to be filtered
        filtOut = filter(1, a(i,:), filtBuf);    
        y(((i-1)*h)+1:((i-1)*h)+fftSize) ...
            = y(((i-1)*h)+1:((i-1)*h)+fftSize) + filtOut.*hanning(fftSize);
                                                    %Overlap and add
    end
    y = y / max(abs(y));    %Normalize output signal
end
