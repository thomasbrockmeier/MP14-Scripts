function [ pleasureMat, familiarMat, concentrMat ] = fig2()

files = dir([pwd '\*_analysis.mat']);

pleasureMat = zeros(15, 28);    % Matrix(Stimulus, Subject)
familiarMat = zeros(15, 28);
concentrMat = zeros(15, 28);

DFA_acousticfeaturesTemplate = load('I:\DFA_acousticfeaturesTemplate.mat');
musicDFA_list(1:15) = DFA_acousticfeaturesTemplate.DFArray{1:15, 2};
                                                               % | Rhythm(!)
                                                 
% [ musicDFA_list, MDL_Idx ] = sort(musicDFA_list, 'descend');
MDL_Idx = MDL_Idx + 1;  % +1 lines it up with DFA_acousticfeaturesTemplate

subjectIdx = 0;
for i = 1:length(files)
    % Counters
    if mod(i, 15) == 1
            subjectIdx = subjectIdx + 1;
    end
    segmentID = i - ((subjectIdx - 1) * 15);
    
    % Load biomarkers
    bioMarkers = load(files(i).name);
    pleasureMat(segmentID, subjectIdx) = bioMarkers.rsq.Answers(1);
    familiarMat(segmentID, subjectIdx) = bioMarkers.rsq.Answers(2);
    concentrMat(segmentID, subjectIdx) = bioMarkers.rsq.Answers(3);
end

% Delete repeated stimuli
pleasureMat([6 12 15], :) = [];
familiarMat([6 12 15], :) = [];
concentrMat([6 12 15], :) = [];
DFA_acousticfeaturesTemplate.DFArray([6 12 15], :) = [];

% Plot
f = figure
s = subplot(1, 4, 1)
plot([DFA_acousticfeaturesTemplate.DFArray{1:12, 2}], 0.5:1:11.5, '*')
s = subplot(1, 4, 2)
boxplot(pleasureMat', 'orientation', 'horizontal')
s = subplot(1, 4, 3)
boxplot(familiarMat', 'orientation', 'horizontal')
s = subplot(1, 4, 4)
boxplot(concentrMat', 'orientation', 'horizontal')

end