function [ BPM, grid, onsets, onsetsS, S, DFA_Obj, DFA_Exp ] = rhythmGrid(input)
% Creates a grid of 32nd notes for a given sound file (.wav), with an
% indication of the presence of an onset for every given 32nd note in the
% input fragment.
%
% Requires MIRToolbox!
% Requires Chronux!

%% Collect information on the audio file (input) and note length
% Read audio file
[ audioFile, sampleRate ] = audioread(input);

% Get BPM and onsets with MIRToolbox
BPMObj = mirtempo(input);
BPM    = get(BPMObj, 'Data');
BPM    = BPM{1, 1}{1, 1}{1,1};

OnsetObj  = mironsets(input, 'Sampling', 44100, 'Attacks', 'Releases');
onsets    = get(OnsetObj, 'AttackPosUnit');
onsets    = onsets{1, 1}{1, 1}{1, 1};
onsetsS   = onsets * sampleRate;     % Get onset position in sample number
releases  = get(OnsetObj, 'ReleasePosUnit');
releases  = releases{1, 1}{1, 1}{1, 1};
releasesS = releases * sampleRate;

% Get 32nd note length in seconds
tsndNote = 0.125 * 60 / BPM;

% Get nSamples per 32nd note and total amount of 32nd notes
tsndNSamp     = sampleRate * tsndNote;
tsndNoteTotal = size(audioFile, 1) / tsndNSamp;

% Empty vector for all 32nd notes in the segment
grid = zeros(ceil(tsndNoteTotal), 5);
mult = 1:size(grid, 1);
mult = mult';

% Enter 32nd note ending positions in samples and time in seconds
grid(:, 4) = tsndNSamp;
grid(:, 4) = grid(:, 4) .* mult(:);
grid(:, 5) = tsndNote;
grid(:, 5) = grid(:, 5) .* mult(:);
counter = 0;

%% Find onset positions and durations in 32nd note grid
for i = 1:(size(onsetsS, 1) - 1)
    currOns = onsetsS(i, 1);
    nextOns = onsetsS((i + 1), 1);
    currRel = releasesS(i, 1);
    nextRel = releasesS((i + 1), 1);
    
    % Find first position in grid where currOns sample position is smaller 
    % than the 32nd note onset. Subtract 1 to find 32nd note bin number.
    tsndPosCurrOns = find(currOns <= grid(:, 4), 1);
    tsndPosNextOns = find(nextOns <= grid(:, 4), 1);
    
    tsndPosCurrRel = find(currRel <= grid(:, 4), 1);
    tsndPosNextRel = find(nextRel <= grid(:, 4), 1);

    % And add flag to grid, meaning that an onset it present in this
    % particular 32nd note bin.
    grid(tsndPosCurrOns, 1) = grid(tsndPosCurrOns, 1) + 1;
    grid(tsndPosCurrOns, 1) = tsndPosNextOns - tsndPosCurrOns;
    
    grid(tsndPosCurrRel, 2) = grid(tsndPosCurrRel, 2) + 1;
    grid(tsndPosCurrRel, 2) = tsndPosNextRel - tsndPosCurrRel;
    
    
    
    
%     % And add onset time.
%     if grid(i, 1) ~= 0
%         counter = counter + 1;
%         grid(tsndPosCurrOns, NNN) = onsets(counter);
%     end
 
end

% %% Compute multitaper rhythm spectrum
% % Set parameters for mtspectrumpt()
% PARAMS = struct('tapers', [2 3], 'Fs', 10);
% 
% [ S, f, ~ ] = mtspectrumpt(onsets, PARAMS);      % SHOULD GIVE (500+:1)
%                                                   % vector!
% 
% %% Compute DFA
% SignalInfo = nbt_Info;
% SignalInfo.converted_sample_frequency = 10;
% 
% % Specify percentage of the signal to be 'removed' at the beginning and end
% % and compute calculation interval
% remPerc = 8;
% calcMin = remPerc / 10;
% calcMax = size(S, 1) - size(S, 1) / 100 * remPerc;
% 
% %[DFAobject,DFA_exp] = 
% [ DFA_Obj, DFA_Exp ] = nbt_doDFA(S, SignalInfo, [1 25], [0.8 50], 0.5, 1, 1, []);
% 
end