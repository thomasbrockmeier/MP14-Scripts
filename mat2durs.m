function noteDurs = mat2durs(noteMatrix)

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
end