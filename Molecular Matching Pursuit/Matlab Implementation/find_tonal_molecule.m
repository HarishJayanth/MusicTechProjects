function [mdctCoeff, tonal_molecule_signal] = find_tonal_molecule....
    (mdctCoeff, S, k, p, mdctCoeffThresh, preEchoSuppression)
    
    pend = p;
    while pend<size(mdctCoeff,2) && S(k,pend+1) > S(k,pend)/3 && S(k,pend+1) > 2*mdctCoeffThresh
       pend = pend + 1;
    end
    
    pbegin = p;
    while pbegin>1 && S(k,pbegin-1) > S(k,pbegin)/3 && S(k,pbegin-1) > 2*mdctCoeffThresh
        pbegin = pbegin - 1;
    end
    
    tonal_molecule = get_tube(mdctCoeff, pbegin, pend, k, 1);
    

    for i = pbegin:pend
        if abs(tonal_molecule(k,i)) < mdctCoeffThresh
            tonal_molecule(k,i) = 0;
        end
        if (k+1 <= size(mdctCoeff,1))
            if abs(tonal_molecule(k+1,i)) < mdctCoeffThresh
                tonal_molecule(k+1,i) = 0;
            end
        end
        if (k-1 >= 1)
            if abs(tonal_molecule(k-1,i)) < mdctCoeffThresh
                tonal_molecule(k-1,i) = 0;
            end
        end
    end
    if preEchoSuppression == 1
        reference_molecule = get_tube(mdctCoeff, pbegin, pend, k, 20);
        [tonal_molecule, tonal_molecule_signal] = suppress_pre_echo....
            (tonal_molecule, reference_molecule, pbegin, pend);
    else
        tonal_molecule_signal = imdct(tonal_molecule, 2*size(tonal_molecule,1));
    end
    mdctCoeff = mdctCoeff - tonal_molecule;
end