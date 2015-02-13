function fig3()

files = dir([pwd '\*_analysis.mat']);

segmentIDs = ['BH1'; 'BH2'; 'BR1'; 'BR2'; 'CH1'; 'CH2'; 'GR1'; 'GR2'; ...
    'HD1'; 'HD2'; 'MZ1'; 'MZ2'];

pleasureMat = zeros(15, 28);    % Matrix(Stimulus, Subject)
familiarMat = zeros(15, 28);
concentrMat = zeros(15, 28);

% DFA_acousticfeaturesTemplate = load('I:\DFA_acousticfeaturesTemplate.mat');
% musicDFA_list(1:15) = [DFA_acousticfeaturesTemplate.DFArray{1:15, 2}];

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
% musicDFA_list([6 12 15]) = [];

h = figure;
jitterAmount = 0.25;
for j = 1:size(pleasureMat, 1)
    
    jitterValuesX = 2 * (rand(1, size(pleasureMat, 2)) - 0.5) * jitterAmount;
    jitterValuesY = 2 * (rand(1, size(familiarMat, 2)) - 0.5) * jitterAmount;
    jitterValuesZ = 2 * (rand(1, size(concentrMat, 2)) - 0.5) * jitterAmount;

    scatter3(pleasureMat(j, :) + jitterValuesX, familiarMat(j, :)...
        + jitterValuesY, concentrMat(j, :) + jitterValuesZ, '.');
    hold on
end

legend(segmentIDs, 'Location', 'BestOutside');
set(gca, 'XLimMode', 'manual', 'XLim', [-1 7], 'YLimMode', 'manual', ...
    'YLim', [-1 7], 'ZLimMode', 'manual', 'ZLim', [-1 7]);