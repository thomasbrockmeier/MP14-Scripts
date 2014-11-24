% Create a Signal object from a wav file
s = Signal('bach_a_minor.wav');

%set window length to 50ms
s.windowLength = 50;

%set window overlap to 75%
s.overlapRatio = 0.75;

%compute STFT
s.STFT;

%display log-spectrogram
figure(1)
clf
subplot 311
imagesc(10*log10(abs(s.S(1:s.nfftUtil,:,1)).^2));
xlabel('frame')
ylabel('frequency bin')
axis xy
title('spectrogram')

%compute f0 between 200 and 500Hz
pitchs = s.mainPitch(200,500);

%display it
subplot 312
plot(pitchs)
xlabel('frame')
ylabel('f0 (Hz)')
grid on
title('f0 detection')

%Compute onsets that both appear and low and high frequencies
onsets = s.getOnsets(0,500).*s.getOnsets(6000,15000);

%display them
subplot 313
plot(onsets)
xlabel('frame')
ylabel('onset presence')
grid on
title('onset detection') 