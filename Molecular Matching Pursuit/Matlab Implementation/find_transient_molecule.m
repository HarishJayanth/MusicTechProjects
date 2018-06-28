function [transient_wt, wt] = find_transient_molecule(wt, Kmax, KmaxIndex, coeffThresh, n)
    
    transient_wt = wt;
    treeSpan = n / (2*length(wt.cfs{wt.level}));
    tl = floor(KmaxIndex / treeSpan)*treeSpan + 1;
    tr = ceil(KmaxIndex / treeSpan)*treeSpan;
    l = wt.level;
    
    for i = 1:length(wt.cfs)
        sel{i} = zeros(size(wt.cfs{i}));
    end
    
    for i = 1:l
        for j = ceil(tl/2^(i-1)):ceil(tr/2^(i-1))
            if (sel{i}(j) ~= 0) continue;
            end
            if (abs(wt.cfs{i}(j))>coeffThresh)
                for k = 1:l-i
                    if (sel{i+k}(ceil(j/2^k)) ~= 0)
                        break;
                    else
                        sel{i+k}(ceil(j/2^k)) = wt.cfs{i+k}(ceil(j/2^k));
                        wt.cfs{i+k}(ceil(j/2^k)) = 0;
                    end
                end
            end
        end
    end
    sel{l}(ceil(tl/2^(l-1))) = wt.cfs{l}(ceil(tl/2^(l-1)));
    wt.cfs{l}(ceil(tl/2^(l-1))) = 0;
    transient_wt.cfs = sel;
end
