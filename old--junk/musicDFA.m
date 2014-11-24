function [ DFA_Exp ] = loudnessDFA(input)
% Compute scaling exponent of loudness curve

% Read audio file, convert to mono and downsample to 1/4th of the original 
% sample frequency
[ audioFile, SR ] = audioread(input);
audioFile   = (audioFile(:, 1) + audioFile(:, 2)) / 2;
audioFile   = audioFile(1:4:size(audioFile, 1))';
audioLength = length(audioFile) / (SR / 4);
calcMax     = ceil(audioLength - audioLength / 10);

% Create info object
SignalInfo = nbt_Info;
SignalInfo.converted_sample_frequency = SR / 4; 

% Set filter properties and compute amplitude envelope of R channel
hp = 0.1;
lp = 10;
ampEnv = nbt_GetAmplitudeEnvelope(audioFile, SignalInfo, hp, lp, 2/hp);

[~,DFA_exp] = nbt_doDFA(AmplitudeEnvelope, SignalInfo, [0.1 10], [0.05 70], 0.5, 1, 1, []);