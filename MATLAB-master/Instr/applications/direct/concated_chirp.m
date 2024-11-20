function [time, mchirp] = concated_chirp(sampleRateDAC, fStart_l, rampTime_l, fStop_l)
    assert ((length(fStart_l) == length(rampTime_l)) ...
        && (length(fStop_l) == length(rampTime_l)), ...
        'length of the fStart_l, rampTime_l, and fStop_l are all the same');
    time = [];
    chirp_l = [];
    dt = 1/sampleRateDAC;
    current_t = 0;
    for idx = (1: length(fStart_l))
        tp = 0:dt:rampTime_l(idx)-dt;
        chirp_l = [chirp_l, chirp(tp, fStart_l(idx), rampTime_l(idx), fStop_l(idx))];
        current_t = current_t + rampTime_l(idx);
        time = [time, tp+current_t];
    end
    mchirp = cat(2, chirp_l);
end