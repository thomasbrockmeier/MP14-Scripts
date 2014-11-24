function [ DFA_Exp, ampEnv ] = loudnessDFA(input)
% Compute scaling exponent of loudness curve

% Read audio file, convert to mono and downsample to 1/DSth of the original 
% sample frequency
[ audioFile, SR ] = audioread(input);

% Downsample parameter (44K1 Hz / DS)
DS   = 8;
SRDS = SR / DS;

% Separate channels, calculate mono, and down sample
rightChannel(:, 1) = audioFile(:, 1);
leftChannel(:, 1)  = audioFile(:, 2); 
monoAverage(:, 1)  = (audioFile(:, 1) + audioFile(:, 2)) / 2;

rightChannel = rightChannel(1:DS:size(rightChannel, 1));
leftChannel  = leftChannel(1:DS:size(leftChannel, 1));
monoAverage  = monoAverage(1:DS:size(monoAverage, 1));

audioLength = length(rightChannel) / SRDS;
calcMax     = ceil(audioLength - audioLength / 10);

% Set filter properties and compute amplitude envelopes
%   hpCut: 60 seconds (half of the 120 second signal)
%   lpCut: 10 Hz (cf. Voss & Clark)
hpCut = 1/60;
lpCut = 10;

% Define ampEnv and DFA_Exp
ampEnv  = zeros(length(rightChannel), 3);
DFA_Exp = zeros(1, 3);

% Create info object
SignalInfo = nbt_Info;
SignalInfo.converted_sample_frequency = SRDS; 

% Compute amplitude envelopes and DFA
ampEnv(:, 1) = nbt_GetAmplitudeEnvelope(rightChannel, SignalInfo, hpCut, lpCut, 2/hpCut);
ampEnv(:, 2) = nbt_GetAmplitudeEnvelope(leftChannel, SignalInfo, hpCut, lpCut, 2/hpCut);
ampEnv(:, 3) = nbt_GetAmplitudeEnvelope(monoAverage, SignalInfo, hpCut, lpCut, 2/hpCut);

[~, DFA_Exp(1)] = nbt_doDFA(ampEnv(:, 1), SignalInfo, [0.1 30], [0.05 calcMax], 0.5, 0, 1, []);
[~, DFA_Exp(2)] = nbt_doDFA(ampEnv(:, 2), SignalInfo, [0.1 30], [0.05 calcMax], 0.5, 0, 1, []);
[~, DFA_Exp(3)] = nbt_doDFA(ampEnv(:, 3), SignalInfo, [0.1 30], [0.05 calcMax], 0.5, 0, 1, []);