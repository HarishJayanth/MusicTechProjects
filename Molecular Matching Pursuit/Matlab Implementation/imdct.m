function y = imdct(mdctCoeff, winLen)
    win = sin(2*pi*[1:winLen]/(2*winLen))';
    
    [numFreq, numFrame] = size(mdctCoeff);
    
    y = zeros(numFreq*(numFrame+1),1);
    
    mdctCoeff = dct(mdctCoeff, 'Type', 4);
    mdctCoeff = [mdctCoeff(numFreq/2+1:numFreq,:); ...
                -mdctCoeff(numFreq:-1:numFreq/2+1,:); ...
                -mdctCoeff(numFreq/2:-1:1,:); ...
                -mdctCoeff(1:numFreq/2,:)];
    mdctCoeff = win.*mdctCoeff;
    
    for i=1:numFrame
        sample_index = (i-1)*numFreq+1;
        y(sample_index:sample_index+2*numFreq-1,1) = ...
            y(sample_index:sample_index+2*numFreq-1,1) + mdctCoeff(:,i);
    end
    
    y = y(numFreq+1:end-numFreq);
end
