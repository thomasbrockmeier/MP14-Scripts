function intervals = pitchDFA(pitchesRawCell, onsets)
% Get vector of intervals from pitch and onset data


% Check for chords and convert cell to matrix manually (cell2mat() returns
% an error)
pitchesRaw = zeros(size(pitchesRawCell));
chordRem = 0;
for i = 1:length(pitchesRawCell)
    if length(pitchesRawCell{1, i}) > 1 && ~isempty(pitchesRawCell{1, i}) == 1
        % Remove chords and set lowest frequency
        chordRem = chordRem + 1;
        pitchesRawCell{1, i} = min(pitchesRawCell{1, i});
    end
    % Cell 2 mat
    if isempty(pitchesRawCell{1, i})
        pitchesRaw(1, i) = NaN;
    else
        pitchesRaw(1, i) = pitchesRawCell{1, i};
    end
end

% Get frequency values of piano keys based on set frequency of A4. 88 note
% keyboard assumed
A4 = 440;
keys = A4 * (2 .^(1/12)) .^((-47:40) - 1);

% Convert unique frequencies to frequencies associated with piano keys
pitchesKeys = pitchesRaw;
keyNumber = zeros(size(pitchesRaw));
for ii = 1:length(pitchesRaw)
    if ~isnan(pitchesRaw(ii))
        [ ~, keyNumber(ii) ] = min(abs(keys - pitchesRaw(ii)));
        pitchesKeys(ii) = keys(keyNumber(ii));
    end
end

% Get pitches at onsets..
pitchOn = zeros(size(onsets));
temp = zeros(10, 1);
intervals = zeros(size(onsets - 1));
for iii = 1:length(onsets)
    for j = 1:3
        countJ = iii + j - 1;
        try
        temp(j) = pitchesKeys(str2double(num2str(round(onsets(countJ) * 100))));
        catch err
        end
    end
    temp(1) = mean(temp(~isnan(temp)));
    [ ~, pitchOn(iii) ] = min(abs(keys - temp(1)));
    
    % ... and their relative intervals (interval gets reset at octave
    % boundary)
    if iii > 1
        intervals(iii - 1) = rem(abs(pitchOn(iii) - pitchOn(iii - 1)), 12);
    end
end

end