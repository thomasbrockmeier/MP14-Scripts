function intervals = intervalCollectKey(pitchesRawCell, tuningFreq, keyFreq)
% Get vector of intervals from pitch and onset data
%
% Smoothing variable indicates how far ahead the function will look (in
% tens of milliseconds) for pitch information. All values will then be 
% averaged - a large value will therefore lead to an overly smooth curve, 
% whereas a small value will lead to many empty values.

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
A4 = tuningFreq;
keys = A4 * (2 .^(1/12)) .^((-47:40) - 1);
% Key number of root tone
keyKey = find(keys == keyFreq);

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
            keyNumberTrimmed(c) = keyNumber(iii);
    end
end

% Get intervals and collapse into single octave cf. Hsu & Hsu (1990)
intervals           = abs(keyNumberTrimmed - keyKey);
remInts             = intervals == keyKey;
int8va12            = intervals == 12;
int8va12            = int8va12 * 12;
int8va24            = intervals == 24;
int8va24            = int8va24 * 12;
int8va36            = intervals == 36;
int8va36            = int8va36 * 12;
intervals           = rem(intervals, 12);
intervals           = intervals + int8va12 + int8va24 + int8va36;
intervals(remInts)  = [];

end