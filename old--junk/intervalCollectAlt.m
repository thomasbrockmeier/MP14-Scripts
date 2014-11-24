function intervals = intervalCollectAlt(pitchesRawCell)
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

% Remove double consecutive values from keyNumber
c = 0;
for iii = 1:length(keyNumber)
    if iii > 1 && (keyNumber(iii) ~= keyNumber(iii - 1))
            c = c + 1;
            value(c) = keyNumber(iii);
    end
end

value = value(value ~= 0);

for iiii = 1:length(value)
    if iiii > 1
        % Set interval
        if abs(value(iiii) - value(iiii - 1)) == 12
            value(iiii - 1) = 12;
        else
            value(iiii - 1) = rem(abs(value(iiii) - value(iiii - 1)), 12);
        end
        if iiii > 2 && (value(iiii - 1) == 1 && value(iiii - 2) == 1)
            % Filter out extensive amounts of semitone intervals e.g.,
            % trills and ornamental playing
            value(iiii - 2) = 99;
        end
    end
end

value(value == 99) = [];
value(end) = [];
intervals = value;