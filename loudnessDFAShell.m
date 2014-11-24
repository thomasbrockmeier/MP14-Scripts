files        = dir('E:\Thomas\Stimuli\Stimuli\');
files([1 2]) = [];
nFiles       = length(files);

for i = 1:nFiles
    fileName = files(i).name;
    fileName(find(fileName == '.')) = '_';
    [ DFA_Exp, ampEnv ]   = loudnessDFA(files(i).name);
    output.(fileName).DFA = DFA_Exp;
    output.(fileName).amp = ampEnv;
end