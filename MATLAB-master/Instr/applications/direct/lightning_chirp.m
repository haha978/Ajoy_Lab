function lchirp = lightning_chirp(t,fStart,rampTime,fStop, bow_coordinate)
    % Lightning chirp generator.
    % bow_coordinate is a (t,f) coordinate in the first half of the time, which will symmetrically be extended to a 'lightning' like form
    %           /
    %          /
    %   ______
    %  /
    % /
    % Check if coordinate is valid
    assert(bow_coordinate(1) < rampTime/2, 'Bow coordinate must be in the first half of the time');
    assert(bow_coordinate(1) > 0, 'Bow coordinate must be positive');
    assert(bow_coordinate(2) < fStop, 'Bow coordinate must be within the frequency range');
    assert(bow_coordinate(2) > 0, 'Bow coordinate must be positive');
    
    fRange = fStop - fStart;
    
    dt = t(2) - t(1);
    t0 = 0:dt:bow_coordinate(1);
    t1 = 0:dt:rampTime/2-bow_coordinate(1);
    t2 = 0:dt:rampTime/2-bow_coordinate(1);
    t3 = 0:dt:bow_coordinate(1);
    
    % Generate first half:
    % Generate chirp from start to bow_coordinate
        % note this is the matlab default chirp
    chirp0 = chirp(t0, fStart, bow_coordinate(1), fStart+bow_coordinate(2));
    chirp1 = chirp(t1, fStart+ bow_coordinate(2), rampTime/2-bow_coordinate(1), fStart + fRange/2);
    % Generate symmetric extension
    chirp2 = chirp(t2, fStart + fRange/2, rampTime/2-bow_coordinate(1), fStop - bow_coordinate(2));
    chirp3 = chirp(t3, fStop - bow_coordinate(2), bow_coordinate(1), fStop);
    % Combine chirps
    %lchirp = cat(1, chirp0, chirp1, chirp2, chirp3);
    lchirp = [chirp0, chirp1, chirp2, chirp3];
    %truncate the lchirp to fit t
    lchirp = lchirp(1:length(t));
    
end