function [ seg_subjectDFADiff, seg_musicECRDiff ] = musicDFA_deltaBrainDFA(musDim)
% Correlates DFA(music) and (DFA(brain, music) - DFA(brain, ECR)).
%   musDim = (2: Rhy.; 3: Pit.; 4: Lou.; 5: Avg.)

% Initialize vars
filesMUS = dir([pwd '\*_analysis.mat']);
filesECR = dir([pwd '\ecr\*_analysis.mat']);
nSubjects = length(filesECR);
bioMarkersNamesDFA = { 'DFA_1_4Hz'; 'DFA_4_8Hz'; 'DFA_8_13Hz'; 'DFA_13_30Hz'; ...
    'DFA_30_45Hz'; 'DFA_55_125Hz'; 'DFA_60_90Hz' };
subjectECRDFA = zeros(nSubjects, 7, 129);
subjectMUSDFA = zeros(length(filesMUS), 7, 129);
subjectDFADiff = subjectMUSDFA;
musicECRDiff = subjectMUSDFA;

% Load music DFAs
DFArray = load('I:\DFA_acousticfeaturesTemplate.mat');
DFArray = DFArray.DFArray;

% Get brain(ECR) DFAs...
for i = 1:nSubjects
    fileNameCond = filesECR(i).name;
    bioMarkers = load([pwd '\ecr\' fileNameCond]);
    
    % ... per biomarker
    for ii = 1:7
        ECRDFAs = eval(strcat('bioMarkers.', bioMarkersNamesDFA{ii}, '.MarkerValues'));
        subjectECRDFA(i, ii, 1:129) = ECRDFAs(1:129);
    end
end

subjectIdx = 0;
% Get brain(music) DFAs...
for j = 1:length(filesMUS)
    fileNameCond = filesMUS(j).name;
    bioMarkers = load([pwd '\' fileNameCond]);
    
    % Counters for subsequent loop
    if mod(j, 15) == 1
            subjectIdx = subjectIdx + 1;
    end
    
    segmentIdx = j - ((subjectIdx - 1) * 15);
    
    % ... per biomarker...
    for jj = 1:7
        MUSDFAs = eval(strcat('bioMarkers.', bioMarkersNamesDFA{jj}, '.MarkerValues'));
        subjectMUSDFA(j, jj, 1:129) = MUSDFAs(1:129);
        
        % ... and substract corresponding brain(ECR) DFAs
        subjectDFADiff(j, jj, 1:129) = subjectMUSDFA(j, jj, 1:129) - subjectECRDFA(subjectIdx, jj, 1:129);
        
        % Do so for music DFA - ECR as well
        musicDFAvec = ones(1, 129) * DFArray{segmentIdx, musDim};
        ECRDFAvec(1:129) = subjectECRDFA(subjectIdx, jj, 1:129);
        musicECRDiff(j, jj, 1:129) = musicDFAvec - ECRDFAvec;
    end
end

seg_subjectDFADiff = zeros(15 * nSubjects, 7, 129);
seg_musicECRDiff = zeros(15 * nSubjects, 7, 129);
% Get average DFA values per segment
for k = 1:15
    for kk = 1:nSubjects
        target = k * kk;
        for kkk = 1:7
            seg_subjectDFADiff(kk, kkk, 1:129) = subjectDFADiff(target, kkk, 1:129);
            seg_musicECRDiff(kk, kkk, 1:129) = musicECRDiff(target, kkk, 1:129);
        end
    end
end

seg_subjectDFADiff(seg_subjectDFADiff == 0) = [];
seg_musicECRDiff(seg_musicECRDiff == 0) = [];

end