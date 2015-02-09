function pleasureBrain128PLOTTERv2(r, p, corrType)

chanlocs = load('chanlocs.mat');
chanlocs = chanlocs.chanlocs;

bioMarkersNamesDFA = { 'DFA 1 - 4 Hz'; 'DFA 4 - 8 Hz'; 'DFA 8 - 13 Hz'; ...
    'DFA 13 - 30 Hz'; 'DFA 30 - 45 Hz'; 'DFA 55 - 125 Hz'; 'DFA 60 - 90 Hz' };

for i = 1:3 % Low/Mid/High
    figure('units', 'normalized', 'position', [0.1 0.1 0.8 0.5]);
    if i == 1
        title(sprintf(['Correlations Between Music Pleasure Ratings ', ...
            'and Music DFA\n Low ECR DFA Group (N = 9, %s)'], ...
            corrType), 'fontweight', 'bold');
    elseif i == 2
        title(sprintf(['Correlations Between Music Pleasure Ratings ', ...
            'and Music DFA\n Mid ECR DFA Group (N = 10, %s)'], ...
            corrType), 'fontweight', 'bold');
    elseif i == 3
        title(sprintf(['Correlations Between Music Pleasure Ratings ', ...
            'and Music DFA\n High ECR DFA Group (N = 9, %s)'], ...
            corrType), 'fontweight', 'bold');
    end
    
    axis off
    
    ha = tight_subplot(2, 7, [0 0], [0 0], [0 0]);
    
    coolWarm = load('nbt_CoolWarm.mat', 'coolWarm');
    coolWarm = coolWarm.coolWarm;
    colormap(coolWarm);
    
    for ii = 1:1 % Biomarker(DFA)
        % Topoplot correlation coefficients
%         subplot(2, 7, ii)
        axes(ha(ii));
        disp(r(i, :))
        topoplot(r(i, :), chanlocs, 'headrad', 'rim');
        title(bioMarkersNamesDFA{ii});
        colorbar('westoutside');
        
        % Topoplot corresponding p-values
%         subplot(2, 7, ii + 7)
        axes(ha(ii + 7));
        topoplot(log10(p(i, :)), chanlocs, 'headrad', 'rim');
        title('p-Values');
        cbh = colorbar('westoutside');
        caxis([-2 -0.5])
        set(cbh, 'YTick', [-2 -1.3010 -1 0])
        set(cbh, 'YTicklabel', [0.01 0.05 0.1 1]) % (log scale trick)
    end
end
end