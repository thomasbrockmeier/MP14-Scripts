function output = DFAShellMIDI(pad, Fs, nShuff)

javaaddpath('E:\Thomas\MATLAB\miditoolbox\midi_lib\KaraokeMidiJava.jar');

dirs        = dir(pad);
dirs([1 2]) = [];
nDirs       = size(dirs, 1);

for i = 1:nDirs
    dirName = dirs(i).name;
    try
        [ output.(dirName).DFA, output.(dirName).noteMatrix ] = ...
            MIDIDFA(strcat(pad, dirName, '\'), Fs, nShuff);
    catch err
    end
end
end