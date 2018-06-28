% [x, fs] = audioread('audio_sample4.wav');
% x = x(:,1);

function [transient_signal, tonal_signal, res] = molecular_matching_pursuit()
    
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
    W = evalin('base','W');

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
            transient_molecule_signal = idddtree(transient_wt);
            res = res - transient_molecule_signal;
            transient_signal = transient_signal + transient_molecule_signal;
            mdctCoeff = mdct(res, L);
        else
            [mdctCoeff, tonal_molecule_signal] = find_tonal_molecule....
                (mdctCoeff, S, Tmaxk, Tmaxp, mdctCoeffThresh, preEchoSuppression);
            tonal_molecule_signal = tonal_molecule_signal(1:length(x));
            res = res - tonal_molecule_signal;
            tonal_signal = tonal_signal + tonal_molecule_signal;
            wt = dddtree('dwt', res, l, 'db4');
        end
    
        if prevRes == res
           break;
        end
        prevRes = res;
    end
end









% figure;
% subplot 221;
% plot(x);
% subplot 222;
% plot(res);
% subplot 223;
% plot(transient_signal);
% subplot 224;
% plot(tonal_signal);

