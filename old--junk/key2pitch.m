function output = key2pitch(input, tuningFreq)
% Compute segment key frequency from string input and A4 frequency

A = tuningFreq;

if strcmp(input, 'C')
    output = A * 2 .^(1/12) .^ -9;
elseif strcmp(input, 'C#')
    output = A * 2 .^(1/12) .^ -8;
elseif strcmp(input, 'D')
    output = A * 2 .^(1/12) .^ -7;
elseif strcmp(input, 'D#')
    output = A * 2 .^(1/12) .^ -6;
elseif strcmp(input, 'E')
    output = A * 2 .^(1/12) .^ -5;
elseif strcmp(input, 'F')
    output = A * 2 .^(1/12) .^ -4;
elseif strcmp(input, 'F#')
    output = A * 2 .^(1/12) .^ -3;
elseif strcmp(input, 'G')
    output = A * 2 .^(1/12) .^ -2;
elseif strcmp(input, 'G#')
    output = A * 2 .^(1/12) .^ -1;
elseif strcmp(input, 'A')
    output = A * 2 .^(1/12) .^ 0;
elseif strcmp(input, 'A#')
    output = A * 2 .^(1/12) .^ 1;
elseif strcmp(input, 'B')
    output = A * 2 .^(1/12) .^ 2;
end
end