function [time, mchirp] = added_chirp(sampleRateDAC, fStart_l, rampTime, fStop_l)
    assert (length(fStart_l) == length(fStop_l),'length of the fStart_l, rampTime_l, and fStop_l are all the same');
    chirp_l = [];
    dt = 1/sampleRateDAC;
    current_t = 0;
    time = 0:dt:rampTime-dt;
    for idx = (1: length(fStart_l))
        tp = 0:dt:rampTime-dt;
        chirp_l = [chirp_l; chirp(tp, fStart_l(idx), rampTime, fStop_l(idx))];
    end
    mchirp = sum(chirp_l);
end