function [ conditions, f ] = conditionsARSQ()
% Retrieves subject responses per condition
%
% E.g., targetDir = 'I:\Music_project\all subjects - DFA'; pwd
% Requires nbt_NBTRunAnalysisPleasureRatings_DFAmusic to have been run

%% Call vars
files = dir([pwd '\*_analysis.mat']);
nSubjects = floor(length(files) / 15);      % n Files / 15 conditions                                           % unused subjects

conditionsList = {'BH1', 'BH2', 'BR1', 'BR2', 'CH1', 'CH1R', 'CH2', ...
    'GR1', 'GR2', 'HD1', 'HD2', 'HD2R', 'MZ1', 'MZ2', 'MZ2R'};
conditions = cell(5, 15);

pleasure = zeros(nSubjects, 1);
familiar = zeros(nSubjects, 1);
concetration = zeros(nSubjects, 1);
eyesOpen = zeros(nSubjects, 1);

sPlotID = [1 5 9 2 6 10 3 7 11 4 8 12];

%% Create cell array containing subject responses
for i = 1:length(conditionsList)
    for ii = 1:nSubjects
        % Load biomarkers
        fileNameCond = files(i + 15 * (ii - 1)).name;
        bioMarkers = load([pwd '\' fileNameCond]);
        responses = bioMarkers.rsq.Answers;
        
        % Retrieve subject's responses
        pleasure(ii, 1) = responses(1);
        familiar(ii, 1) = responses(2);
        concetration(ii, 1) = responses(3);
        eyesOpen(ii, 1) = responses(4);
        rhythmDFA = responses(5);
        pitchDFA = responses(6);
        loudnessDFA = responses(7);
        averageDFA = responses(8);
    end 
    
    % Fill cell array
    conditions{1, i} = conditionsList{i};
    conditions{2, i} = pleasure;
    conditions{3, i} = familiar;
    conditions{4, i} = concetration;    
    conditions{5, i} = eyesOpen;
    conditions{6, i} = rhythmDFA;
    conditions{7, i} = pitchDFA;
    conditions{8, i} = loudnessDFA;
    conditions{9, i} = averageDFA;
end

% Get response frequencies
conditionsTemp = conditions;
conditionsTemp(1, :) = [];
[~, freqPL] = cellfun(@mode, conditionsTemp);

%% Create histograms of subject responses per condition
for j = 4:-1:1
    figure
    
    for jj = 1:length(conditionsList)
        subplot(3, 5, jj);
        
        if j == 4
            [ f, x ] = hist(conditions{j + 1, jj}, 0:1);
            h = bar(x, f);
            axis([-1 2 0 max(freqPL(j, :)) + 1]);
        else
            [ f, x ] = hist(conditions{j + 1, jj}, 0:6);
            h = bar(x, f);
            axis([-1 7 0 max(freqPL(j, :)) + 1]);
        end
        
        title(conditionsList{jj});
        xlabel('Response');
        ylabel('Frequency');
        set(h, 'FaceColor', [0 0.5 0.5], 'EdgeColor', 'none');
    end
    
    if j == 4
        suptitle(sprintf('Subjects with Eyes Closed (0)/Open (1) per Condition, N = %d', nSubjects));
    elseif j == 3
        suptitle(sprintf('Concentration Ratings per Condition, N = %d', nSubjects));
    elseif j == 2
        suptitle(sprintf('Familiarity Ratings per Condition, N = %d', nSubjects));
    elseif j == 1
        suptitle(sprintf('Pleasurability Ratings per Condition, N = %d', nSubjects));
    end
end

%% Create histograms of subject responses per DFA condition
for k = 1:4                                        % Responses
    if k == 1
        DFAcond = 'Pleasurability Ratings';
        condRow = 2;
    elseif k == 2
        DFAcond = 'Familiarity Ratings';
        condRow = 3;
    elseif k == 3
        DFAcond = 'Concentration Ratings';
        condRow = 4;
    elseif k == 4
        DFAcond = 'Subjects with Eyes Closed (0)/Open (1)';
        condRow = 5;
    end
    
    figure
    sPlotct = 0;
    for kk = 1:4                                   % R/P/L/Avg
        if kk == 1
            DFArow = 6;
            DFAtype = 'Rhythm ';
        elseif kk == 2
            DFArow = 7;
            DFAtype = 'Pitch ';
        elseif kk == 3
            DFArow = 8;
            DFAtype = 'Loudness ';
        elseif kk == 4
            DFArow = 9;
            DFAtype = 'RPL DFA_a_v_g ';
        end
        
        for kkk = 1:3                              % DFA bins
            if kkk == 1
                minTargetDFA = 0;
                maxTargetDFA = 0.65;
                DFAtitle = 'DFA < 0.65';
            elseif kkk == 2
                minTargetDFA = 0.65;
                maxTargetDFA = 0.85;
                DFAtitle = '0.65 < DFA < 0.85';
            elseif kkk == 3
                minTargetDFA = 0.85;
                maxTargetDFA = 2;
                DFAtitle = 'DFA > 0.85';
            end
            
            c = 0;
            targetStim = [];
            for kkkk = 1:length(conditionsList)    % Stimuli
                if conditions{DFArow, kkkk} > minTargetDFA && ...
                        conditions{DFArow, kkkk} < maxTargetDFA
                    c = c + 1;
                    targetStim(c) = kkkk;
                end
            end

            concatVec = [];
            for kkkkk = 1:length(targetStim)       % Concatenate vectors...
                targetVec = conditions{condRow, targetStim(kkkkk)};
                targetVec = targetVec';
                concatVec = [concatVec targetVec];
            end
            
            sPlotct = sPlotct + 1;
            nDFACond = length(concatVec) / length(conditions{2, 1});
            subplot(3, 4, sPlotID(sPlotct))        % ... and plot.
            [ f, x ] = hist(concatVec, 0:6);
            disp(f/sum(f))
            h = bar(x, f/sum(f) * 100);
            title(sprintf('%s\n%s%s, N_S_t_i_m_u_l_i = %d', DFAcond, DFAtype, DFAtitle, nDFACond));
            xlabel('Response');
            ylabel('Frequency (%)');
            set(h, 'FaceColor', [0 0.5 0.5], 'EdgeColor', 'none');
            if k ~= 4
                axis([-1 7 0 50]);
            else
                axis([-1 1.9999 0 100]);
            end
            
            if sPlotct == 12
                suptitle([DFAcond ' Per DFA Category']);
            end
        end
    end
end
end