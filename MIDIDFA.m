function [ outputData, noteMatrixStruct ] = MIDIDFA(fileDir, Fs, nShuff)
% javaaddpath('E:\Thomas\MATLAB\miditoolbox\midi_lib\KaraokeMidiJava.jar')

files        = dir(fileDir);
files([1 2]) = [];
nFiles       = length(files);

rhythmEXP  = zeros(nFiles, 1);
pitchEXP   = zeros(nFiles, 1);
outputData = cell(nFiles, 10);

% Perform DFA analysis for rhythm and pitch information
for i = 1:nFiles
    fprintf('Working... Processing %s%s\n', fileDir, files(i).name)
    % Get noteMatrix from MIDI file
    noteMatrix = readmidi_java(strcat(fileDir, files(i).name));
    noteMatrixStruct.(strcat('n',num2str(i))) = noteMatrix;
    try
        [ ~, rhythmEXP(i), DFAVecShuffR, nNotes ] = evalc('rhythmDFA_MIDI(noteMatrix, Fs, nShuff)');
    catch err
        rhythmEXP(i) = NaN;
        fprintf('\nERROR: Rhythm exponent for %s%s not obtained!\n', fileDir, files(i).name)
    end
    try
        [ ~, pitchEXP(i), DFAVecShuffP ]  = evalc('pitchDFA_MIDI(noteMatrix, Fs, nShuff)');
    catch err
        pitchEXP(i) = NaN;
        fprintf('\nERROR: Pitch exponent for %s%s not obtained!\n', fileDir, files(i).name)
    end
    
    % Add data to cell array
    outputData{i, 1} = files(i).name;
    outputData{i, 2} = rhythmEXP(i);
    outputData{i, 3} = DFAVecShuffR';
    
    meanRhyShuff     = mean(DFAVecShuffR);
    stdRhyShuff      = std(DFAVecShuffR);
    outputData{i, 4} = [ meanRhyShuff stdRhyShuff ];
    
    outputData{i, 5} = pitchEXP(i);
    outputData{i, 6} = DFAVecShuffP';
    
    meanPitShuff     = mean(DFAVecShuffP);
    stdPitShuff      = std(DFAVecShuffP);
    outputData{i, 7} = [ meanPitShuff stdPitShuff ];
    
    outputData{i, 8} = nNotes;
end

% Remove skipped compositions and calculate scaling exponent descriptives
rhythmEXP  = rhythmEXP(~isnan(rhythmEXP));
pitchEXP   = pitchEXP(~isnan(pitchEXP));
meanRhythm = mean(rhythmEXP);
stdRhythm  = std(rhythmEXP);
meanPitch  = mean(pitchEXP);
stdPitch   = std(pitchEXP);

% Add to cell array
outputData{1, 9} = 'Mean R:';
outputData{2, 9} = 'sDev R:';
outputData{3, 9} = 'Mean P:';
outputData{4, 9} = 'sDev P:';

outputData{1, 10} = meanRhythm;
outputData{2, 10} = stdRhythm;
outputData{3, 10} = meanPitch;
outputData{4, 10} = stdPitch;

outputData(2:end + 1, :) = outputData(1:end, :);

outputData{1, 1} = 'Filename:';
outputData{1, 2} = 'Scaling Exp. Rhythm:';
outputData{1, 3} = 'Scaling Exp.s Shuff. Rhythm:';
outputData{1, 4} = '[ Mean SD ] Col. 4';
outputData{1, 5} = 'Scaling Exp. Pitch:';
outputData{1, 6} = 'Scaling Exp.s Shuff. Pitch:';
outputData{1, 7} = '[ Mean SD ] Col. 6';
outputData{1, 8} = 'Length(notes)';
outputData{1, 9} = [];
outputData{4, 10} = [];
end