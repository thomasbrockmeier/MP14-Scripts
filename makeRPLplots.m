function makeRPLplots()
% Plots the rhythm, pitch, and loudness countours for the stimuli used in
% MP14.

load('E:\Thomas\Data\Music Analysis\intervals_noteDurs_vectors.mat')
segments = ['BH1'; 'BH2'; 'BR1'; 'BR2'; 'CH1'; 'CH2'; 'GR1'; 'GR2'; ...
    'HD1'; 'HD2'; 'MZ1'; 'MZ2'];

for i = 1:length(segments)
    figure
    
    %%  Rhythm Subplot (cf. Levitin et al., 2012):
    %   When multiple notes are sounded together, only the shortest one is
    %   considered. The rhythm continues to unfold while the longer notes
    %   linger on. Note release times are not considered to contribute to 
    %   the rhythm, only successive onsets.
    subplot(3, 1, 1)
    plot(eval(['noteDurs' segments(i, :)]))
    xlabel('Successive Note Onset')
    ylabel('Note Duration (Beats)')
    xlim([0 length(eval(['noteDurs' segments(i, :)]))])
    title('Note Durations per Onset')
    
    %%  Pitch Subplot (cf. Hsu & Hsu, 1990):
    %   When multiple notes are sounded together, the successive interval
    %   from all of these notes to the next are considered. This way
    %   harmonic information invoked by chords is preserved.
    subplot(3, 1, 2)
    plot(eval(['intervals' segments(i, :)]))
    xlabel('Successive Interval')
    ylabel('Note Interval (Semitones)')
    xlim([0 length(eval(['intervals' segments(i, :)]))])
    title('Size of Successive Pitch Intervals')
    
    %%  Loudness Subplot (cf. Voss & Clark, 1975; Linkenkaer Hansen et al., 2001)
    %   The stereo channels of the music are averaged together into a
    %   single mono channel, of which the amplitude envelope is computed.
    %
    %   2756 Hz = 44100 Hz / 16
    subplot(3, 1, 3)
    plot(eval(['monoAmp' segments(i, :)]))
        env = eval(['monoAmp' segments(i, :)]);     % Compensate for loudness curve...
        plot(env((0.5 * length(env)):length(env)))  % ... compression idiosyncrasies...
    xlabel('Time (Samples (SR = 2756 Hz))')         % ... in time dimension.
    ylabel('Amplitude(ADD UNIT)')
    xlim([0 (0.5 * length(eval(['monoAmp' segments(i, :)])))])
    title('Loudness Envelope of the Auditory Signal')
    
   %%   Title
   titleString = ['Rhythm, Pitch, and Loudness Contours for Segment ' segments(i, :)];
   ha = axes('Position', [0 0 1 1], 'Xlim', [0 1], 'Ylim', [0 1], 'Box', ...
       'off', 'Visible', 'off', 'Units', 'normalized', 'clipping' , 'off');
   text(0.5, 1, titleString, 'HorizontalAlignment', 'center', ...
       'VerticalAlignment', 'top', 'FontWeight', 'bold')
   
end
end