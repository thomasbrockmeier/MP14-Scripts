function [ rP, pP, rS, pS, rK, pK ] = pleasureBrainAvgECR(behaVar, DFAVar)
    % behaVars:                             % DFAVars:
    % (:, 1) = Pleasurability rating        % (:, 5) = DFA Rhythm
    % (:, 2) = Familiarity rating           % (:, 6) = DFA Pitch
    % (:, 3) = Concentratedness rating      % (:, 7) = DFA Loudness (Mono)
    % (:, 4) = Eyes opened/closed rating    % (:, 8) = Mean DFA music

filesMUS = dir([pwd '\*_analysis.mat']);
filesECR = dir([pwd '\ecr\*_analysis.mat']);
nSubjects = length(filesECR);
bioMarkersNamesDFA = { 'DFA_1_4Hz'; 'DFA_4_8Hz'; 'DFA_8_13Hz'; 'DFA_13_30Hz'; ...
    'DFA_30_45Hz'; 'DFA_55_125Hz'; 'DFA_60_90Hz' };
meanDFAs = zeros(nSubjects, 7);
subjectMeanDFA = zeros(nSubjects, 1);

    rP = zeros(3, 7);       pP = zeros(3, 7);
    rS = zeros(3, 7);       pS = zeros(3, 7);
    rK = zeros(3, 7);       pK = zeros(3, 7);

for i = 1:nSubjects
    fileNameCondECR = filesECR(i).name;
    bioMarkers = load([pwd '\ecr\' fileNameCondECR]);
    
    for ii = 1:7
        ECRDFAs = eval(strcat('bioMarkers.', bioMarkersNamesDFA{ii}, '.MarkerValues'));
        ECRDFAs = ECRDFAs(1:128);
        ECRDFAs(isnan(ECRDFAs)) = [];
        meanDFAs(i, ii) = mean(ECRDFAs);
    end
    
    subjectMeanDFA(i) = mean(meanDFAs(i, :));
end

for band = 1:1
    [ ~, ECRDFAIdx ] = sort(meanDFAs(:, band));
    
%     ECRDFALowID = ECRDFAIdx(1:9);
%     ECRDFAMidID = ECRDFAIdx(10:19);
%     ECRDFAHighID = ECRDFAIdx(20:28);
    
    ECRDFALowID = ECRDFAIdx;
    ECRDFAMidID = ECRDFAIdx;
    ECRDFAHighID = ECRDFAIdx;
    
    lowBrainDFA_resp = zeros(15 * 9, 8);
    midBrainDFA_resp = zeros(15 * 10, 8);
    highBrainDFA_resp = zeros(15 * 9, 8);
    
    cc = 0;
    for jjj = 1:length(ECRDFAMidID)     % N subjects per condition (9 or 10)
        for jjjj = 0:14                 % N MUS_analysis.mat files per subject
            cc = cc + 1;
            if jjj < length(ECRDFAMidID)% Mid has one extra subject
                bioMarkersMUS = load(filesMUS(ECRDFALowID(jjj) * 15 - 14 + jjjj).name);
                lowBrainDFA_resp(cc, :) = bioMarkersMUS.rsq.Answers';
                
                bioMarkersMUS = load(filesMUS(ECRDFAMidID(jjj) * 15 - 14 + jjjj).name);
                midBrainDFA_resp(cc, :) = bioMarkersMUS.rsq.Answers';
                
                bioMarkersMUS = load(filesMUS(ECRDFAHighID(jjj) * 15 - 14 + jjjj).name);
                highBrainDFA_resp(cc, :) = bioMarkersMUS.rsq.Answers';
            else
                bioMarkersMUS = load(filesMUS(ECRDFAMidID(jjj) * 15 - 14 + jjjj).name);
                midBrainDFA_resp(cc, :) = bioMarkersMUS.rsq.Answers';
            end
        end
    end
    
    % Calculate correlation coefficients
    [ rP(1, band), pP(1, band) ] = corr(lowBrainDFA_resp(:, behaVar), ...
        lowBrainDFA_resp(:, DFAVar), 'type', 'Pearson');
    [ rP(2, band), pP(2, band) ] = corr(midBrainDFA_resp(:, behaVar), ...
        midBrainDFA_resp(:, DFAVar), 'type', 'Pearson');
    [ rP(3, band), pP(3, band) ] = corr(highBrainDFA_resp(:, behaVar), ...
        highBrainDFA_resp(:, DFAVar), 'type', 'Pearson');
    
    [ rS(1, band), pS(1, band) ] = corr(lowBrainDFA_resp(:, behaVar), ...
        lowBrainDFA_resp(:, DFAVar), 'type', 'Spearman');
    [ rS(2, band), pS(2, band) ] = corr(midBrainDFA_resp(:, behaVar), ...
        midBrainDFA_resp(:, DFAVar), 'type', 'Spearman');
    [ rS(3, band), pS(3, band) ] = corr(highBrainDFA_resp(:, behaVar), ...
        highBrainDFA_resp(:, DFAVar), 'type', 'Spearman');
    
    [ rK(1, band), pK(1, band) ] = corr(lowBrainDFA_resp(:, behaVar), ...
        lowBrainDFA_resp(:, DFAVar), 'type', 'Kendall');
    [ rK(2, band), pK(2, band) ] = corr(midBrainDFA_resp(:, behaVar), ...
        midBrainDFA_resp(:, DFAVar), 'type', 'Kendall');
    [ rK(3, band), pK(3, band) ] = corr(highBrainDFA_resp(:, behaVar), ...
        highBrainDFA_resp(:, DFAVar), 'type', 'Kendall');
end

disp(pP <= 0.05)
disp(pS <= 0.05)
disp(pK <= 0.05)