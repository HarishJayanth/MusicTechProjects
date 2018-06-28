function y = mdct(x, winLen)
    numSamp = length(x);
    win = sin(2*pi*[1:winLen]/(2*winLen))';
    
    numFrame = ceil(2*numSamp/winLen) + 1;
    
    sig = [zeros(winLen/2,1); x; zeros(numFrame*winLen/2 - numSamp, 1)];
    
    y = zeros(winLen/2, numFrame);
    
    for i = 1:numFrame
        sample_index = winLen/2*(i-1);
        seg = sig(1+sample_index:winLen+sample_index).*win;
        
        y(:,i) = [-seg(3*winLen/4:-1:winLen/2+1)-seg(3*winLen/4+1:winLen); ...
                    seg(1:winLen/4)-seg(winLen/2:-1:winLen/4+1)];
    end
    
    y = dct(y, 'Type', 4);
end

