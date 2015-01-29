function brainResponse = pleasureDFA()

%% Call vars
filesMUS = dir([pwd '\*_analysis.mat']);
filesECR = dir([pwd '\ecr\*_analysis.mat']);
nSubjects = floor(length(filesMUS) / 15);      % n Files / 15 conditions

bioMarkersNamesDFA = { 'DFA_1_4Hz'; 'DFA_4_8Hz'; 'DFA_8_13Hz'; 'DFA_13_30Hz'; ...
    'DFA_30_45Hz'; 'DFA_55_125Hz'; 'DFA_60_90Hz' };

bioMarkersNamesAmp = { 'amplitude_1_4_Hz'; 'amplitude_4_8_Hz'; 'amplitude_8_13_Hz'; ...
    'amplitude_13_30_Hz'; 'amplitude_30_45_Hz'; 'amplitude_55_125_Hz' };

bioMarkersNamesAmpN = { 'amplitude_1_4_Hz_Normalized'; 'amplitude_4_8_Hz_Normalized'; 'amplitude_8_13_Hz_Normalized'; ...
    'amplitude_13_30_Hz_Normalized'; 'amplitude_30_45_Hz_Normalized'; 'amplitude_55_125_Hz_Normalized' };

conditionsList = {'BH1', 'BH2', 'BR1', 'BR2', 'CH1', 'CH1R', 'CH2', ...
    'GR1', 'GR2', 'HD1', 'HD2', 'HD2R', 'MZ1', 'MZ2', 'MZ2R'};

targetElectrodes = [ 11, 62, 75, 129 ];           % Fz, Pz, Oz, Cz
targetVal  = zeros(1, nSubjects);

%% Create struct containing subject brain responses
for i = 1:nSubjects
    fileNameCondECR = filesECR(i).name;
    bioMarkersECR = load([pwd '\ecr\' fileNameCondECR]);
    
        % Get subject i ECR biomarkers
        for iii = 1:length(bioMarkersNamesDFA)
            getBM = strcat('bioMarkersECR.', bioMarkersNamesDFA{iii}, ...
                '.MarkerValues(', num2str(targetElectrodes(1)), ')');
            brainResponse.(['S' num2str(i)]).(bioMarkersNamesDFA{iii}).ECR = eval(getBM);
            
            try
                getBM = strcat('bioMarkersECR.', bioMarkersNamesAmp{iii}, ...
                '.Channels(', num2str(targetElectrodes(1)), ')');
                brainResponse.(['S' num2str(i)]).(bioMarkersNamesAmp{iii}).ECR = eval(getBM);
                
                getBM = strcat('bioMarkersECR.', bioMarkersNamesAmpN{iii}, ...
                '.Channels(', num2str(targetElectrodes(1)), ')');
                brainResponse.(['S' num2str(i)]).(bioMarkersNamesAmpN{iii}).ECR = eval(getBM);
                
            catch err
            end
        end
    
    for ii = 1:length(conditionsList)    
        fileNameCondMUS = filesMUS(ii + 15 * (i - 1)).name;
        bioMarkersMUS = load([pwd '\' fileNameCondMUS]);
        
        % Get subject i condition ii biomarkers
        for iii = 1:length(bioMarkersNamesDFA)
            getBM = strcat('bioMarkersMUS.', bioMarkersNamesDFA{iii}, ...
                '.MarkerValues(', num2str(targetElectrodes(1)), ')');
            brainResponse.(['S' num2str(i)]).(bioMarkersNamesDFA{iii}).(conditionsList{ii}) = eval(getBM);
            
            try
                getBM = strcat('bioMarkersMUS.', bioMarkersNamesAmp{iii}, ...
                '.Channels(', num2str(targetElectrodes(1)), ')');
                brainResponse.(['S' num2str(i)]).(bioMarkersNamesAmp{iii}).(conditionsList{ii}) = eval(getBM);
                
                getBM = strcat('bioMarkersMUS.', bioMarkersNamesAmpN{iii}, ...
                '.Channels(', num2str(targetElectrodes(1)), ')');
                brainResponse.(['S' num2str(i)]).(bioMarkersNamesAmpN{iii}).(conditionsList{ii}) = eval(getBM);
                
            catch err
            end
        end
    end
end
end
