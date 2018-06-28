% [x, fs] = audioread('audio_sample4.wav');
% x = x(:,1);

function molecular_matching_pursuit()
    
    x = evalin('base','x');
    l = 8;
    x = [x; zeros(2^l*ceil(length(x)/2^l) - length(x), 1)];
    n = length(x);
    res = x;    %initialize residual
    L = evalin('base','winLen');    %window length
    
    wt = dddtree('dwt', res, l, 'db4');
    mdctCoeff = mdct(res, L);

    wtCoeffThresh = evalin('base','wtCoeffThresh');%0.05;
    mdctCoeffThresh = evalin('base','mdctCoeffThresh');%0.001;
    W = evalin('base','persistence');

    transient_signal = zeros(size(x));
    tonal_signal = zeros(size(x));
    
    Kmax = 1;
    Tmax = 1;
    KmaxThresh = evalin('base','KmaxThresh');
    TmaxThresh = evalin('base','TmaxThresh');
    prevRes = zeros(size(res));
    
    KTratio = evalin('base','ratio');
    preEchoSuppression = evalin('base','preEchoSuppression');
    
    while (Kmax>KmaxThresh || Tmax > TmaxThresh)
        K = compute_regularity_modulus(wt, 0.8, n);
        [Kmax,KmaxIndex] = max(K);
    
        [T, S] = compute_tonality_index(mdctCoeff, W);
        [Tmax, TmaxIndex] = max(T);
        [Tmax, Tmaxp] = max(Tmax);
        Tmaxk = TmaxIndex(Tmaxp);
    
        if (Kmax > KTratio*Tmax)
            [transient_wt, wt] = find_transient_molecule(wt,Kmax, KmaxIndex, wtCoeffThresh, n);
            transient_molecule = idddtree(transient_wt);
            res = res - transient_molecule;
            transient_signal = transient_signal + transient_molecule;
            mdctCoeff = mdct(res, L);
        else
            [tonal_mdct, mdctCoeff] = find_tonal_molecule(mdctCoeff, S, Tmaxk, Tmaxp, mdctCoeffThresh);
            tonal_molecule = imdct(tonal_mdct, L);
            tonal_molecule = tonal_molecule(1:length(x));
            res = res - tonal_molecule;
            tonal_signal = tonal_signal + tonal_molecule;
            wt = dddtree('dwt', res, l, 'db4');
        end
    
    if prevRes == res
        break;
    end
    prevRes = res;

end
end









figure;
subplot 221;
plot(x);
subplot 222;
plot(res);
subplot 223;
plot(transient_signal);
subplot 224;
plot(tonal_signal);

