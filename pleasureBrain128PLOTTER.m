function pleasureBrain128PLOTTER(r, p)

coolWarm = load('nbt_CoolWarm.mat','coolWarm');
coolWarm = coolWarm.coolWarm;
colormap(coolWarm);

minPValue = -2;
maxPValue = -0.5;

for i = 1:3             % Low/Mid/High
    figure;
    
    for ii = 1:7        % Biomarker(DFA)
        subplot(2, 7, ii)
        topoplot(r(i, ii, :), chanlocs, 'headrad','rim');
        
        subplot(2, 7, ii + 7)
        topoplot(log10(v), chanlocs, 'headrad','rim');
        
        cbh = colorbar('westoutside');
        caxis([minPValue maxPValue])
        
        set(cbh,'YTick',[-2 -1.3010 -1 0])
        set(cbh,'YTicklabel',[0.01 0.05 0.1 1]) %(log scale)
    end
end