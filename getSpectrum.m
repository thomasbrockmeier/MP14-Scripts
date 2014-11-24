function [ S, f ] = getSpectrum(input, type, Fs)
% Get spectrum
%
% Type 1 = Point Process Time       e.g., onset times
% Type 2 = Binned Point Process     e.g., spike train
%
% Binned point process data is supplied to the routines in the same matrix 
% format as continuous data, but in this case the values for each element 
% are interpreted as counts. Point process data supplied as times, on the 
% other hand, must be input to Chronux routines as a structure array of 
% spike times (with field name ‘times’), with dimension of channels or 
% trials - also accepts 1d array of spike times.

% Set parameters for mtspectrumpt()
PARAMS = struct('tapers', [2 3], 'Fs', Fs);

if type == 1
    [ S, f, ~ ] = mtspectrumpt(input, PARAMS);
elseif type == 2
    [ S, f, ~ ] = mtspectrumpb(input, PARAMS);
end
end