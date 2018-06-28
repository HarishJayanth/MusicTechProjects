function k = compute_regularity_modulus(wt, gamma, n)
    k = zeros(size(wt.cfs{1}));
    for i = wt.level:-1:1
        c = repmat(wt.cfs{i}.^gamma, 1, n/(2*length(wt.cfs{i})))';
        k = k + abs(c(:))/wt.level;
    end
end