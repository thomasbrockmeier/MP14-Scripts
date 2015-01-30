function [ rP, pP, rS, pS, rK, pK ] = pleasureBrain128()

%% Call vars
filesMUS = dir([pwd '\*_analysis.mat']);
filesECR = dir([pwd '\ecr\*_analysis.mat']);
nSubjects = length(filesECR);

bioMarkersNamesDFA = { 'DFA_1_4Hz'; 'DFA_4_8Hz'; 'DFA_8_13Hz'; 'DFA_13_30Hz'; ...
    'DFA_30_45Hz'; 'DFA_55_125Hz'; 'DFA_60_90Hz' };

rP = zeros(3, length(bioMarkersNamesDFA), 128);
pP = zeros(3, length(bioMarkersNamesDFA), 128);

rS = zeros(3, length(bioMarkersNamesDFA), 128);
pS = zeros(3, length(bioMarkersNamesDFA), 128);

rK = zeros(3, length(bioMarkersNamesDFA), 128);
pK = zeros(3, length(bioMarkersNamesDFA), 128);

% bioMarkersNamesAmp = { 'amplitude_1_4_Hz'; 'amplitude_4_8_Hz'; 'amplitude_8_13_Hz'; ...
%     'amplitude_13_30_Hz'; 'amplitude_30_45_Hz'; 'amplitude_55_125_Hz' };
%
% bioMarkersNamesAmpN = { 'amplitude_1_4_Hz_Normalized'; 'amplitude_4_8_Hz_Normalized'; 'amplitude_8_13_Hz_Normalized'; ...
%     'amplitude_13_30_Hz_Normalized'; 'amplitude_30_45_Hz_Normalized'; 'amplitude_55_125_Hz_Normalized' };

targetElectrodes = [ 11, 62, 75, 129 ];           % Fz, Pz, Oz, Cz

%% Loop for all electrodes
for q = 1:128
    disp(['Computing channel ' num2str(q) '...'])
    %% Get ECR DFAs
    for i = 1:nSubjects
        fileNameCondECR = filesECR(i).name;
        bioMarkersECR = load([pwd '\ecr\' fileNameCondECR]);
        
        % Get subject i ECR biomarkers
        for ii = 1:length(bioMarkersNamesDFA)
            getBioMarker = eval(strcat('bioMarkersECR.', bioMarkersNamesDFA{ii}, ...
                '.MarkerValues(', num2str(q), ')'));
            
            brainResponseECR.(['S' num2str(i)]).(bioMarkersNamesDFA{ii}).ECR = getBioMarker;
        end
    end
    
    %% Get DFA vectors
    for j = 1:length(bioMarkersNamesDFA)
        for jj = 1:nSubjects
            ECRDFAval = eval(strcat('brainResponseECR.', 'S', num2str(jj), '.', bioMarkersNamesDFA{j}, '.ECR'));
            % Reject bad channels
            if isnan(ECRDFAval) == 0
                ECRDFA(jj) = ECRDFAval;
            end
        end
        
        [ ~, ECRDFAIdx ] = sort(ECRDFA);
        
        % Subject IDs of participants with low, mid, high ECR DFA
        ECRDFALowID = ECRDFAIdx(1:9);
        ECRDFAMidID = ECRDFAIdx(10:19);
        ECRDFAHighID = ECRDFAIdx(20:28);
        
        % Create response and music DFA matrices for each ECR DFA condition
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
        [ rP(1, j, q), pP(1, j, q) ] = corr(lowBrainDFA_resp(:, 1), lowBrainDFA_resp(:, 7), 'type', 'Pearson');
        [ rP(2, j, q), pP(2, j, q) ] = corr(midBrainDFA_resp(:, 1), midBrainDFA_resp(:, 7), 'type', 'Pearson');
        [ rP(3, j, q), pP(3, j, q) ] = corr(highBrainDFA_resp(:, 1), highBrainDFA_resp(:, 7), 'type', 'Pearson');
        
        [ rS(1, j, q), pS(1, j, q) ] = corr(lowBrainDFA_resp(:, 1), lowBrainDFA_resp(:, 7), 'type', 'Spearman');
        [ rS(2, j, q), pS(2, j, q) ] = corr(midBrainDFA_resp(:, 1), midBrainDFA_resp(:, 7), 'type', 'Spearman');
        [ rS(3, j, q), pS(3, j, q) ] = corr(highBrainDFA_resp(:, 1), highBrainDFA_resp(:, 7), 'type', 'Spearman');
        
        [ rK(1, j, q), pK(1, j, q) ] = corr(lowBrainDFA_resp(:, 1), lowBrainDFA_resp(:, 7), 'type', 'Kendall');
        [ rK(2, j, q), pK(2, j, q) ] = corr(midBrainDFA_resp(:, 1), midBrainDFA_resp(:, 7), 'type', 'Kendall');
        [ rK(3, j, q), pK(3, j, q) ] = corr(highBrainDFA_resp(:, 1), highBrainDFA_resp(:, 7), 'type', 'Kendall');
    end
    
    disp('OK')
end

%% Plot
pleasureBrain128PLOTTER(rP, pP, 'Pearson')
pleasureBrain128PLOTTER(rS, pS, 'Spearman')
pleasureBrain128PLOTTER(rK, pK, 'Kendall')
end