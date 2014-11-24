function [ DFA_Exp, onsets, S, f ] = rhythmDFA(input)
% Creates a grid of 32nd notes for a given sound file (.wav), with an
% indication of the presence of an onset for every given 32nd note in the
% input fragment.
%
% Requires MIRToolbox!
% Requires Chronux!

%% Collect information on the audio file (input)
% Get onsets with MIRToolbox
OnsetObj = mironsets(input, 'Sampling', 44100, 'Attacks');
onsets   = get(OnsetObj, 'AttackPosUnit');
onsets   = onsets{1, 1}{1, 1}{1, 1};

%% Compute multitaper rhythm spectrum
% Set parameters for mtspectrumpt()
PARAMS = struct('tapers', [2 3], 'Fs', 10);

[ S, f, ~ ] = mtspectrumpt(onsets, PARAMS);

%% Compute DFA
% Specify percentage of the signal to be 'removed' at the beginning and end
% and compute calculation and fitting intervals...
calcMin = 0.5;
calcMax = ceil((size(S, 1) / 10) - (size(S, 1) / 1000 * 5));
fitMin  = 1;
fitMax  = 10;

% ...and perform DFA to obtain the scaling exponent of the rhythm spectrum
SignalInfo = nbt_Info;
SignalInfo.converted_sample_frequency = 10;
[ ~, DFA_Exp ] = nbt_doDFA(S, SignalInfo, [fitMin fitMax], [calcMin calcMax], 0.5, 1, 1, []);

end