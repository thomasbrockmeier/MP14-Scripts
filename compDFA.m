function DFA_Exp = compDFA(signal, convFreq, plotYN)

% Compute DFA
% Specify percentage of the signal to be 'removed' at the beginning and end
% and compute calculation and fitting intervals...
calcMin = 0.5;
% calcMax = ceil((size(signal, 1) / 10) - (size(signal, 1) / 1000 * 5));
calcMax = length(signal) / convFreq;
fitMin  = 1;
fitMax  = length(signal) / convFreq / 10;

% ...and perform DFA to obtain the scaling exponent of the rhythm spectrum
SignalInfo = nbt_Info;
SignalInfo.converted_sample_frequency = convFreq;
[ ~, DFA_Exp ] = nbt_doDFA(signal, SignalInfo, [fitMin fitMax], [calcMin calcMax], 0.5, plotYN, 1, []);

end