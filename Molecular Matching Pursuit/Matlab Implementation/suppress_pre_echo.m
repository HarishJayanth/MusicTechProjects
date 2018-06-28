function [supressed_molecule, tonal_signal] = suppress_pre_echo(tonal_molecule, reference_molecule, pbegin, pend)
    L = 2*size(tonal_molecule,1);
    tonal_signal = imdct(tonal_molecule,L);
    reference_signal = imdct(reference_molecule,L);
    n = length(tonal_signal);
    iMin = (pbegin-2)*L/2;
    if iMin<1 
        iMin = 1;
    end
    iMax = iMin + L/2 - 1;
    u = [zeros(iMin-1,1); ones(n-iMin+1,1)];
    diff = reference_signal - u.*tonal_signal;
    enMin = norm(diff);
    for i=iMin+1:iMax
        u = [zeros(i-1,1); ones(n-i+1,1)];
        diff = reference_signal - u.*tonal_signal;
        en = norm(diff);
        if en < enMin
            enMin = en;
            iMin = i;
%         elseif en > enMin
%             break;
        end
    end
    tonal_signal = [zeros(iMin-1,1); ones(n-iMin+1,1)].*tonal_signal;
    supressed_molecule = mdct(tonal_signal,L);
end