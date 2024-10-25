plot_new_chirp();


function plot_new_chirp()
    samplerateDAC = 9e9;
    rampTime = 1/750;
    dt = 1/samplerateDAC;

    t = 0:dt:rampTime;
    fCenter =3.779e9;
    fSrs = 3.4e9;
    fBw = 25e6;
    fStart = fCenter-fBw/2-fSrs;
    fStop = fCenter + fBw/2-fSrs;
    
    % PLOT chirp function in the time domain
    bow_coordinate = [rampTime/2-dt,0.1];
%     y = lightning_chirp(t,fStart,rampTime,fStop, bow_coordinate);
    y = chirp(t,fStart,rampTime,fStop);
    h = figure(1);
    screenSize = get(0, 'ScreenSize');
    set(h, 'Position', [500 500 screenSize(3)*0.6 screenSize(4)*0.4]);
    plot(t, y, 'LineWidth', 1);
    xlabel('Time (seconds)');  % Label for x-axis
    ylabel('Amplitude [au]'); 
    title('')
    grid on;
    
    h2 = figure(2);
    screenSize = get(0, 'ScreenSize');
    set(h2, 'Position', [500 100 screenSize(3)*0.4 screenSize(4)*0.6]);
    window = 100*floor(samplerateDAC/(fStart));
    overlap = floor(window * 0.7);
    nFFT = window*5;
    [S, F, T_spec] = spectrogram(y,window, overlap, nFFT, samplerateDAC);
    imagesc(T_spec, F, abs(S));
    ylim([fStart-fBw fStop+fBw]);
    axis xy;
    xlabel('Time [s]');  % Label for x-axis
    ylabel('Frequency [Hz]');
    title1 = join(['Frequency vs Time', newline, 'srs frequency: ' + string(fSrs)]);
    title(title1)
    grid on;
    
    
    %PLOT chrip function in the frequency domain
    
end
function plot_sin()
    samplerateDAC = 1e9;
    rampTime = 1e-6;
    dt = 1/samplerateDAC;
    freq = 75.38*1e6;
    t = 0:dt:rampTime;
    y = sin(2*pi*freq*t);
    markerSize = 2;
    figure;
    plot(t, y, 'LineWidth', 1);
    grid on;
    figure;
    scatter(t, y, markerSize, 'filled');
    grid on;
end