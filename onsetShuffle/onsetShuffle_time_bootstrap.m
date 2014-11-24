function output = onsetShuffle_time_bootstrap(onsets, nIter)
% Generate randomized rhythm onset chains and their spectra and scaling
% exponents using DFA
%
% Requires onsets input vector containing onset times obtained from mironsets()
% Requires nIter variable containing the number of times the script should
% reiterate
%
% Requires Chronux toolbox
% Requires NBT toolbox

% Set size of output vector containing scaling exponents of bootstrapped
% rhythm spectra
output = zeros(nIter, 1);

% Apply mtspectrumpt() settings
PARAMS = struct('tapers', [2 3], 'Fs', 10);

% Create vector b containing all note lengths
b = zeros(length(onsets), 1);
for i = length(onsets):-1:2
    b(i) = onsets(i) - onsets(i - 1);
end
b(1) = [];

% Status update
fprintf('Obtaining scaling exponent: '); 

for ii = 1:nIter
    % Display counter in command window
    if ii > 1
        for jjj = 0:floor(log10(ii - 1)) + floor(log10(nIter)) + 2
            fprintf('\b'); % delete previous counter display
        end
    end
    fprintf('%.0f/%.0f', ii, nIter)

    % Create vector c using a random sample with replacement (bootstrap) from
    % vector b. c contains a random selection of note lengths from b, but with
    % double picks (and therefore does not contain all individual values from b
    % either)
    c = zeros(length(onsets), 1);
    for j = 1:length(b)
        randSelect = randi(length(b), 1);
        c(j) = b(randSelect);
    end

    % Create vector d by iteratively summing every onset with its predecessor,
    % thereby creating a vector of times similar to 'onsets', but with the
    % bootstrapped sample c
    d = zeros(length(onsets), 1);
    d(1) = c(1);
    
    for jj = 2:length(d)
        d(jj) = d(jj - 1) + c(jj);
    end
    d(end) = [];
    
    % Compute multitaper spectrum...
    [ S, ~, ~ ] = mtspectrumpt(d, PARAMS);
    
    % ... apply DFA settings...
    calcMin = 0.5;
    calcMax = ceil((size(S, 1) / 10) - (size(S, 1) / 1000 * 5));
    fitMin  = 1;
    fitMax  = 10;

    % ... obtain the scaling exponent of the rhythm spectrum...
    SignalInfo = nbt_Info;
    SignalInfo.converted_sample_frequency = 10;
    [ ~, ~, DFA_Exp ] = evalc('nbt_doDFA(S, SignalInfo, [fitMin fitMax], [calcMin calcMax], 0.5, 0, [], [])');
    
    % ... and add it to the output vector
    output(ii, 1) = DFA_Exp;
end

% Display output mean and sdev
fprintf('\n\n\n\n\nMean scaling exponent of %.0f bootstrapped samples: %f.\n', nIter, mean(output))
fprintf('Sdev of scaling exponents: %f.\n\n\n', std(output))

end