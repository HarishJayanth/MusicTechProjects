%   This function outputs a pitch shifted version of
%   the input signal x whose pitch is shifted by a 
%   specified number of semitones.
function y = pitchShift(x,semitone)
    alpha = pow2(semitone/12);      %time scaling factor
    y = timeScale(x,alpha);         %scaled signal y
    resamp = floor(alpha*10000);
    y = resample(y, 10000, resamp); %pitch shifted output
end

