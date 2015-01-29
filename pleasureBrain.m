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

conditionsList = {'BH1', 'BH2', 'BR1', 'BR2', 'CH1', 'CH1R', 'CH2', ...
    'GR1', 'GR2', 'HD1', 'HD2', 'HD2R', 'MZ1', 'MZ2', 'MZ2R'};

targetElectrodes = [ 11, 62, 75, 129 ];           % Fz, Pz, Oz, Cz

%% Get ECR DFAs
for i = 1:nSubjects
    fileNameCondECR = filesECR(i).name;
    bioMarkersECR = load([pwd '\ecr\' fileNameCondECR]);
    
        % Get subject i ECR biomarkers
        for ii = 1:length(bioMarkersNamesDFA)
            getBioMarker = eval(strcat('bioMarkersECR.', bioMarkersNamesDFA{ii}, ...
                '.MarkerValues(', num2str(targetElectrodes(1)), ')'));
            if isnan(getBioMarker)
                getBioMarker = eval(strcat('bioMarkersECR.', bioMarkersNamesDFA{ii}, ...
                '.MarkerValues(', num2str(targetElectrodes(1) + 1), ')'));
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
    filesMUS(     [[ECRDFALowID]]     (i + 15 * (ii - 1))).name
end