function DFA_Exp = bootboot(onsets)

% Apply mtspectrumpt() settings
PARAMS = struct('tapers', [2 3], 'Fs', 10);

% Compute multitaper spectrum...
[ S, ~, ~ ] = mtspectrumpt(onsets, PARAMS);

% ... apply DFA settings...
calcMin = 0.5;
calcMax = ceil((size(S, 1) / 10) - (size(S, 1) / 1000 * 5));
fitMin  = 1;
fitMax  = 10;

% ... obtain the scaling exponent of the rhythm spectrum...
SignalInfo = nbt_Info;
SignalInfo.converted_sample_frequency = 10;
[ ~, ~, DFA_Exp ] = evalc('nbt_doDFA(S, SignalInfo, [fitMin fitMax], [calcMin calcMax], 0.5, 0, [], [])');
