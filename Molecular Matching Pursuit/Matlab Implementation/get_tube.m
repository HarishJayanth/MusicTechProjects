function tube = get_tube(mdctCoeff, pbegin, pend, k, width)
    tube = zeros(size(mdctCoeff));
    numFreq = size(mdctCoeff,1);
    for i = pbegin:pend
        for k1 = k-width:k+width
            if k1 <= 0 || k1 > numFreq
                continue;
            end
            tube(k1,i) = mdctCoeff(k1,i);
        end
    end
end