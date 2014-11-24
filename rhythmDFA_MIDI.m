function [ DFA_Exp, DFAVecShuff, nNotes ] = rhythmDFA_MIDI(noteMatrix, Fs, nShuff)
% Calculate spectral exponent for rhythmic characteristics of MIDI
% transcribed composition
% [ S, f ] = getSpectrum(noteMatrix(:, 2), 2, Fs);

% Remove notes with length 0
noteMatrix = noteMatrix(noteMatrix(:, 2) ~= 0, 1:7);

% Remove double onsets from MIDI input (shortest note is presented first in
% noteMatrix and is therefore preserved cf. Levitin et al., 2012)
for i = size(noteMatrix, 1):-1:2
    if noteMatrix(i, 1) == noteMatrix(i - 1, 1)
        noteMatrix(i, :) = [];
    end
end

% Create vector of note durations
noteDurs = zeros(size(noteMatrix(:, 1)));
for ii = size(noteMatrix, 1):-1:2
    noteDurs(ii) = noteMatrix(ii) - noteMatrix(ii - 1);
end
noteDurs(1) = [];

nNotes = length(noteDurs);

% DFA
DFA_Exp = 2 * compDFA(noteDurs, Fs, 0) - 1;

% Perform onset shuffling
DFAVecShuff = zeros(nShuff,1);
for iii = 1:nShuff
    DFAVecShuff(iii) = 2 * compDFA(shuffle(noteDurs), Fs, 0) - 1;
end

end