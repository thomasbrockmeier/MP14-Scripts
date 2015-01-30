function ECRDFA = pleasureBrain()

%% Call vars
filesMUS = dir([pwd '\*_analysis.mat']);
filesECR = dir([pwd '\ecr\*_analysis.mat']);
nSubjects = length(filesECR);

bioMarkersNamesDFA = { 'DFA_1_4Hz'; 'DFA_4_8Hz'; 'DFA_8_13Hz'; 'DFA_13_30Hz'; ...
    'DFA_30_45Hz'; 'DFA_55_125Hz'; 'DFA_60_90Hz' };

bioMarkersNamesAmp = { 'amplitude_1_4_Hz'; 'amplitude_4_8_Hz'; 'amplitude_8_13_Hz'; ...
    'amplitude_13_30_Hz'; 'amplitude_30_45_Hz'; 'amplitude_55_125_Hz' };

bioMarkersNamesAmpN = { 'amplitude_1_4_Hz_Normalized'; 'amplitude_4_8_Hz_Normalized'; 'amplitude_8_13_Hz_Normalized'; ...
    'amplitude_13_30_Hz_Normalized'; 'amplitude_30_45_Hz_Normalized'; 'amplitude_55_125_Hz_Normalized' };

targetElectrodes = [ 11, 62, 75, 129 ];           % Fz, Pz, Oz, Cz

%% Get ECR DFAs
for i = 1:nSubjects
    fileNameCondECR = filesECR(i).name;
    bioMarkersECR = load([pwd '\ecr\' fileNameCondECR]);
    
        % Get subject i ECR biomarkers
        for ii = 1:length(bioMarkersNamesDFA)
            getBioMarker = eval(strcat('bioMarkersECR.', bioMarkersNamesDFA{ii}, ...
                '.MarkerValues(', num2str(targetElectrodes(3)), ')'));
            
            c = 0;
            while isnan(getBioMarker)
                c = c + 1;
                
                getBioMarker = eval(strcat('bioMarkersECR.', bioMarkersNamesDFA{ii}, ...
                '.MarkerValues(', num2str(targetElectrodes(3) + c), ')'));
            end
            
            brainResponseECR.(['S' num2str(i)]).(bioMarkersNamesDFA{ii}).ECR = getBioMarker;
        end
end

%% Get DFA vectors
for j = 1:length(bioMarkersNamesDFA)
    for jj = 1:nSubjects
        ECRDFA(jj) = eval(strcat('brainResponseECR.', 'S', num2str(jj), '.', bioMarkersNamesDFA{j}, '.ECR'));
    end
    
    [ ECRDFASort, ECRDFAIdx ] = sort(ECRDFA);
    
    % Subject IDs of participants with low, mid, high ECR DFA
    ECRDFALowID = ECRDFAIdx(1:9);
    ECRDFAMidID = ECRDFAIdx(10:19);
    ECRDFAHighID = ECRDFAIdx(20:28);
    
    % Read the filenames (15 conditions) for all participants in each of
    % the three vectors. Create vector of music DFAs and second vector of
    % corresponding ratings. Sort DFAs, then reorder ratings so that they
    % match the DFAs again. Plot against each other.
    %
    % Other possibility: correlate vectors to get scatter plot.
    %
    % Do so for all biomarkers (DFA only?)
    lowBrainDFA_resp = zeros(15 * 9, 8);
    midBrainDFA_resp = zeros(15 * 10, 8);
    highBrainDFA_resp = zeros(15 * 9, 8);
    cc = 0;
    for jjj = 1:length(ECRDFAMidID)
        for jjjj = 0:14
            cc = cc + 1;
            if jjj < length(ECRDFAMidID)
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
    disp(bioMarkersNamesDFA{j})
    [ r, p ] = corr(lowBrainDFA_resp(:, 1), lowBrainDFA_resp(:, 7), 'type', 'Spearman');
    disp(r)
    disp(p)
    [ r, p ] = corr(midBrainDFA_resp(:, 1), midBrainDFA_resp(:, 7), 'type', 'Spearman');
    disp(r)
    disp(p)
    [ r, p ] = corr(highBrainDFA_resp(:, 1), highBrainDFA_resp(:, 7), 'type', 'Spearman');
    disp(r)
    disp(p)
end
end