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
    
    %%  Pitch Subplot (cf. Hsu & Hsu, 1990):
    %   When multiple notes are sounded together, the successive interval
    %   from all of these notes to the next are considered. This way
    %   harmonic information invoked by chords is preserved.
    subplot(3, 1, 2)
    plot(eval(['intervals' segments(i, :)]))
    xlabel('Successive Interval')
    ylabel('Note Duration (Semitones)')
    xlim([0 length(eval(['intervals' segments(i, :)]))])
    
    %%  Loudness Subplot (cf. Voss & Clark, 1975; Linkenkaer Hansen et al., 2001)
    %   The stereo channels of the music are averaged together into a
    %   single mono channel, of which the amplitude envelope is computed.
    %
    %   N.B., The dynamic range within the loudness contour can be very
    %   large. As a consequence of this, segments that show very large
    %   differences in loudness (e.g., BH1) can appear partially silent.
    %   This is due to values of differences in orders of magnitude in the
    %   signal and on the y-axis (e.g., X * 10^-9 being plotted on an axis
    %   with a scale of X * 10^-4).
    subplot(3, 1, 3)
    plot(eval(['monoAmp' segments(i, :)]))
    xlabel('Time (Samples (SR = 5512.5 Hz))')
    ylabel('Amplitude()')
    xlim([0 length(eval(['monoAmp' segments(i, :)]))])
end
end