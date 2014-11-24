function [ audioFile, SR, pitchesRawCell, onsets, key, tuningFreq ] = dataLoad(input)
% Load data into MATLAB

% AUDIO (to mono and downsample to SR / 4)
[ audioFile, SR ] = audioread(input);
audioFile   = (audioFile(:, 1) + audioFile(:, 2)) / 2;
audioFile   = audioFile(1:4:size(audioFile, 1));
SR = SR / 4;

% PITCHES
PitchObj       = mirpitch(input,'Frame', 'Reso', 'Semitone');
pitchesRawCell = get(PitchObj, 'Data');
pitchesRawCell = pitchesRawCell{1, 1}{1, 1};

% ONSETS
OnsetObj = mironsets(input, 'Sampling', 44100, 'Attacks');
onsets   = get(OnsetObj, 'AttackPosUnit');
onsets   = onsets{1, 1}{1, 1}{1, 1};

% KEY
KeyObj = mirkeystrength(input);
keyMat    = get(KeyObj, 'Data');
keyMat    = keyMat{1, 1}{1, 1};
tonic  = get(KeyObj, 'Tonic');
tonic  = tonic{1, 1}{1, 1};
[ maxM(1), maxM(2) ] = find(keyMat(:,:,1,1) == max(keyMat(:,:,1,1)));
[ maxm(1), maxm(2) ] = find(keyMat(:,:,1,2) == max(keyMat(:,:,1,2)));
if keyMat(maxM(1), maxM(2),1,1) > keyMat(maxM(1), maxM(2),1,2)
    key = tonic{maxM(1), maxM(2)};
else
    key = tonic{maxm(1), maxm(2)};
end

% TUNING
% tuningFreq should generally be the range 440.0 < A4 < 444.0. However, 
% older pieces may be performed with A4 tuned as low as 415 Hz
SpecObj        = mirspectrum(input, 'Min', 415, 'Max', 450);
power          = get(SpecObj, 'Data');
freq           = get(SpecObj, 'Pos');
[ ~, maxData ] = max(power{1, 1}{1, 1});
tuningFreq     = freq{1, 1}{1, 1}(maxData);

end