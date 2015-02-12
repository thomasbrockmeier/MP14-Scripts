function [ pleasureMat, familiarMat, concentrMat ] = fig2(musDim)

files = dir([pwd '\*_analysis.mat']);

segmentIDs = ['BH1'; 'BH2'; 'BR1'; 'BR2'; 'CH1'; 'CH2'; 'GR1'; 'GR2'; ...
    'HD1'; 'HD2'; 'MZ1'; 'MZ2'];

pleasureMat = zeros(15, 28);    % Matrix(Stimulus, Subject)
familiarMat = zeros(15, 28);
concentrMat = zeros(15, 28);

DFA_acousticfeaturesTemplate = load('I:\DFA_acousticfeaturesTemplate.mat');
musicDFA_list(1:15) = [DFA_acousticfeaturesTemplate.DFArray{1:15, musDim}];

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
musicDFA_list([6 12 15]) = [];

% Sort
[ musicDFA_list, MDL_Idx ] = sort(musicDFA_list, 'ascend');

% Plot
f = figure;
% s = subplot(1, 4, 1);
ha = tight_subplot(1, 4, 0, 0.1, 0.1);
axes(ha(1));
plot(musicDFA_list, 0.5:1:11.5, '*');
title('Stimulus DFA');
set(gca, 'YTick', 0.5:1:11.5, 'YTickLabel', segmentIDs(MDL_Idx, :));
% s = subplot(1, 4, 2);
axes(ha(2));
boxplot(pleasureMat(MDL_Idx, :)', 'orientation', 'horizontal');
title('Pleasure');
set(gca, 'YTick', [], 'YTickLabel', []);
% s = subplot(1, 4, 3);
axes(ha(3));
boxplot(familiarMat(MDL_Idx, :)', 'orientation', 'horizontal');
title('Familiarity');
set(gca, 'YTick', [], 'YTickLabel', []);
% s = subplot(1, 4, 4);
axes(ha(4));
boxplot(concentrMat(MDL_Idx, :)', 'orientation', 'horizontal');
set(gca, 'YTick', 1:12, 'YTickLabel', segmentIDs(MDL_Idx, :), 'yaxislocation', 'right');
title('Concentration');

if musDim == 2
    musDimID = 'Rhythm';
elseif musDim == 3
    musDimID = 'Pitch';
elseif musDim == 4
    musDimID = 'Loudness';
elseif musDim == 5
    musDimID = 'Average Rhythm, Pitch, and Loudness';
end

headerString = [ musDimID ' DFA, and Behavioral Responses per Segment'];
   axes('Position', [0 0 1 1], 'Xlim', [0 1], 'Ylim', [0 1], 'Box', ...
       'off', 'Visible', 'off', 'Units', 'normalized', 'clipping' , 'off');
   text(0.5, 1, headerString, 'HorizontalAlignment', 'center', ...
       'VerticalAlignment', 'top', 'FontWeight', 'bold');
end