function makeRPLplots()
% Plots the rhythm, pitch, and loudness countours for the stimuli used in
% MP14.
%
% Requires modified version of nbt_doDFA (lines 173, 178, and 183 commented
% out; '%0.2f' inserted in line 193; font size modified in lines 191-3).

% Load data
load('E:\Thomas\Data\Music Analysis\intervals_noteDurs_vectors.mat')
segments = ['BH1'; 'BH2'; 'BR1'; 'BR2'; 'CH1'; 'CH2'; 'GR1'; 'GR2'; ...
    'HD1'; 'HD2'; 'MZ1'; 'MZ2'];

fontSize = 10;
mult     = 2.5;

% Create figure for every segment
for i = 1:length(segments)
    %   Generate empty figure
    f = figure('units', 'inches', 'position', [0 0 (mult * 4) (mult * 3)]);
        
    %   Rhythm Subplot (cf. Levitin et al., 2012):
    %
    %   When multiple notes are sounded together, only the shortest one is
    %   considered. The rhythm continues to unfold while the longer notes
    %   linger on. Note release times are not considered to contribute to 
    %   the rhythm, only successive onsets.
    subplot(3, 3, 1:2);
    plot(eval(['noteDurs' segments(i, :)]))
    set(gca, 'Fontsize', fontSize)
    xlabel('Successive Note Onset', 'Fontsize', fontSize)
    ylabel('Note Duration (Beats)', 'Fontsize', fontSize)
    xlim([0 length(eval(['noteDurs' segments(i, :)]))])
    title('Note Durations per Onset', 'Fontsize', fontSize)
    
    h = subplot(3, 3, 3);
    p = get(h, 'position');
    p(1) = p(1) + 0.02;
    compDFA(eval(['noteDurs' segments(i, :)]), 10, 1)
    set(gca, 'Fontsize', fontSize, 'position', p)
    xlabel('log_{10}(onset), [Successive Onsets]', 'Fontsize', fontSize)
    ylabel('log_{10} F(onset)', 'Fontsize', fontSize)
    
    %   Pitch Subplot (cf. Hsu & Hsu, 1990):
    %
    %   When multiple notes are sounded together, the successive interval
    %   from all of these notes to the next are considered. This way
    %   harmonic information invoked by chords is preserved.
    subplot(3, 3, 4:5);
    plot(eval(['intervals' segments(i, :)]))
    set(gca, 'Fontsize', fontSize)
    xlabel('Successive Interval', 'Fontsize', fontSize)
    ylabel('Note Interval (Semitones)', 'Fontsize', fontSize)
    xlim([0 length(eval(['intervals' segments(i, :)]))])
    title('Size of Successive Pitch Intervals', 'Fontsize', fontSize)
    
    h = subplot(3, 3, 6);
    p = get(h, 'position');
    p(1) = p(1) + 0.02;
    compDFA(eval(['intervals' segments(i, :)]), 10, 1)
    set(gca, 'Fontsize', fontSize, 'position', p)
    xlabel('log_{10}(interval), [Successive Intervals]', 'Fontsize', fontSize)
    ylabel('log_{10} F(interval)', 'Fontsize', fontSize)
    
    %   Loudness Subplot (cf. Voss & Clark, 1975; Linkenkaer Hansen et al., 2001)
    %
    %   The stereo channels of the music are averaged together into a
    %   single mono channel, of which the amplitude envelope is computed.
    %
    %   2756 Hz = 44100 Hz / 16
    subplot(3, 3, 7:8);
    plot(eval(['monoAmp' segments(i, :)]))
        env = eval(['monoAmp' segments(i, :)]);     % Compensate for loudness curve...
        plot(env((0.5 * length(env)):length(env)))  % ... compression idiosyncrasies...
        set(gca, 'Fontsize', fontSize)              % ... in time dimension.
    xlabel(sprintf(['Time (Samples (SR = 2756 Hz))\nY-Axis: Absolute '...
        'Value of Normalized 16-Bit Source']), 'Fontsize', fontSize)
    ylabel('Amplitude (Between 0 and 1*)', 'Fontsize', fontSize)
    xlim([0 (0.5 * length(eval(['monoAmp' segments(i, :)])))])
    title('Loudness Envelope of the Auditory Signal')
    
    h = subplot(3, 3, 9);
    p = get(h, 'position');
    p(1) = p(1) + 0.02;
    compDFA(eval(['monoAmp' segments(i, :)]), 2756, 1)
    set(gca, 'Fontsize', fontSize, 'position', p)
    xlabel('log_{10}(time), [Seconds]', 'Fontsize', fontSize)
    ylabel('log_{10} F(time)', 'Fontsize', fontSize)
    
   %    Title
   headerString = ['Rhythm, Pitch, and Loudness Contours for Segment ' ...
       segments(i, :) ' (left; top to bottom),' sprintf('\n')... 
       'and Corresponding DFA plot (right)'];
   axes('Position', [0 0 1 1], 'Xlim', [0 1], 'Ylim', [0 1], 'Box', ...
       'off', 'Visible', 'off', 'Units', 'normalized', 'clipping' , 'off');
   text(0.5, 1, headerString, 'HorizontalAlignment', 'center', ...
       'VerticalAlignment', 'top', 'FontWeight', 'bold', 'Fontsize', fontSize);
       
   hold off
   
%    %    Print to file
%    fn = ['C:\Users\thomas\Desktop\' segments(i, :) '.jpeg'];
%    print(f, fn, '-djpeg');
end
end