function [ DFA_Exp, DFAVecShuff ] = pitchDFA_MIDI(noteMatrix, Fs, nShuff)
% Calculate spectral exponent for pitch distribution of MIDI transcribed 
% composition

% Get successive intervals cf. Hsu & Hsu (1990)
notes = noteMatrix(:, 4);
intervals = zeros(length(notes), 1);
for i = length(notes):-1:2
    intervals(i) = notes(i) - notes(i - 1);
end
intervals(1) = [];
intervals = abs(intervals);

DFA_Exp  = 2 * compDFA(intervals, Fs, 0) - 1;

% Perform onset shuffling
DFAVecShuff = zeros(nShuff,1);
for ii = 1:nShuff
    DFAVecShuff(ii) = 2 * compDFA(shuffle(intervals), Fs, 0) - 1;
end

end