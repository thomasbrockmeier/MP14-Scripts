function f = fig3_v2()

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

pleasureVec = reshape(pleasureMat, [], 1);
familiarVec = reshape(familiarMat, [], 1);
concentrVec = reshape(concentrMat, [], 1);

f = figure;

jitterAmount = 0.33;
jitterValuesP = 2 * (rand(length(pleasureVec), 1) - 0.5) * jitterAmount;
jitterValuesF = 2 * (rand(length(familiarVec), 1) - 0.5) * jitterAmount;
jitterValuesC = 2 * (rand(length(concentrVec), 1) - 0.5) * jitterAmount;

ha1 = subplot(3, 1, 1);
scatter(pleasureVec + jitterValuesP, familiarVec + jitterValuesF, 'b.');
[r, p] = corr(pleasureVec, familiarVec);
hold on
f = fit(pleasureVec, familiarVec, 'poly1');
plot(f);
title(['R = ' num2str(r, 2) ', p = ' num2str(p, 2)]);

ha2 = subplot(3, 1, 2);
scatter(concentrVec + jitterValuesC, pleasureVec + jitterValuesP, 'b.');
[r, p] = corr(concentrVec, pleasureVec);
hold on
f = fit(concentrVec, pleasureVec, 'poly1');
plot(f);
title(['R = ' num2str(r, 2) ', p = ' num2str(p, 2)]);

ha3 = subplot(3, 1, 3);
scatter(familiarVec + jitterValuesF, concentrVec + jitterValuesC, 'b.');
hold on
f = fit(familiarVec, concentrVec, 'poly1');
plot(f);
[r, p] = corr(familiarVec, concentrVec);
title(['R = ' num2str(r, 2) ', p = ' num2str(p, 2)]);
% title(['P1 = ' num2str(f.p1, 2) ', P2 = ' num2str(f.p2, 2)]);

set(ha1, 'XLim', [-1 7], 'YLim', [-1 7], 'XGrid', 'on', 'YGrid', 'on');
xlabel(ha1, 'Pleasurability'); ylabel(ha1, 'Familiarity');
set(ha2, 'XLim', [-1 7], 'YLim', [-1 7], 'XGrid', 'on', 'YGrid', 'on');
xlabel(ha2, 'Concentratedness'); ylabel(ha2, 'Pleasurability');
set(ha3, 'XLim', [-1 7], 'YLim', [-1 7], 'XGrid', 'on', 'YGrid', 'on');
xlabel(ha3, 'Familiarity'); ylabel(ha3, 'Concentratedness');

%    Title
headerString = ['Correlations between Behavioral Responses'];
axes('Position', [0 0 1 1], 'Xlim', [0 1], 'Ylim', [0 1], 'Box', ...
    'off', 'Visible', 'off', 'Units', 'normalized', 'clipping' , 'off');
text(0.5, 1, headerString, 'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'top', 'FontWeight', 'bold');