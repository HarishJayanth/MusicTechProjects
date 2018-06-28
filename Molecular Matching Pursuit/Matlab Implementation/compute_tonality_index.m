function [T, S] = compute_tonality_index(mdctCoeff, W)
    p = size(mdctCoeff,2);
    k = size(mdctCoeff,1);
    betaKp1 = [mdctCoeff(2:end,:);zeros(1,size(mdctCoeff,2))];
    betaKm1 = [zeros(1,size(mdctCoeff,2)); mdctCoeff(1:end-1,:)];
    
    S = sqrt(mdctCoeff.^2 + (betaKp1+betaKm1).^2);
    T = zeros(size(S));
    
    for i = 1:p
        for j=1:k
            for i1 = i:i+W
                if (i1 > p) break;
                end
                T(j,i) = T(j,i) + S(j,i1)/W;
            end
        end
    end
end