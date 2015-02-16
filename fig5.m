function fig5
% pwd = I:\Plots - Compare Biomarker\crop

figures = dir([pwd '\*.tif']);

f1 = figure;
f2 = figure;
f3 = figure;
f4 = figure;
f5 = figure;
f6 = figure;
f7 = figure;
f8 = figure;

imgTitles = {'DFA in 1-4 Hz Band'; 'DFA in 4-8 Hz Band'; 'DFA in 8-13 Hz Band'; ...
    'DFA in 13-30 Hz Band'; 'DFA in 30-45 Hz Band'; 'DFA in 55-125 Hz Band'; ...
    'DFA in 60-90 Hz Band'};
headers = {'Concentratedness'; 'Eyes Open/Closed'; 'Familiarity'; 'Loudness DFA'; ...
    'Pitch DFA'; 'Pleasurability'; 'Rhythm DFA'; 'RPL DFA'};

for i = 1:7
    % Concentratedness
    set(0, 'currentfigure', f1);
    s1 = subplot(1, 7, i);
    img = imread(figures(i).name);
    imshow(img);
    title(imgTitles{i});
    hold on
    
    % Eyes
    set(0, 'currentfigure', f2);
    s2 = subplot(1, 7, i);
    img = imread(figures(i + 7 * 1).name);
    imshow(img);
    title(imgTitles{i});
    hold on
    
    % Familiarity
    set(0, 'currentfigure', f3);
    s3 = subplot(1, 7, i);
    img = imread(figures(i + 7 * 2).name);
    imshow(img);
    title(imgTitles{i});
    hold on
    
    % Loudness DFA
    set(0, 'currentfigure', f4);
    s4 = subplot(1, 7, i);
    img = imread(figures(i + 7 * 3).name);
    imshow(img);
    title(imgTitles{i});
    hold on
    
    % Pitch DFA
    set(0, 'currentfigure', f5);
    s5 = subplot(1, 7, i);
    img = imread(figures(i + 7 * 4).name);
    imshow(img);
    title(imgTitles{i});
    hold on
    
    % Pleasure
    set(0, 'currentfigure', f6);
    s6 = subplot(1, 7, i);
    img = imread(figures(i + 7 * 5).name);
    imshow(img);
    title(imgTitles{i});
    hold on
    
    % Rhythm DFA
    set(0, 'currentfigure', f7);
    s7 = subplot(1, 7, i);
    img = imread(figures(i + 7 * 6).name);
    imshow(img);
    title(imgTitles{i});
    hold on
    
    % RPL DFA
    set(0, 'currentfigure', f8);
    s8 = subplot(1, 7, i);
    img = imread(figures(i + 7 * 7).name);
    imshow(img);
    title(imgTitles{i});
    hold on
    
end

%    Titles
for j = 1:8
    headerString = ['Spearman Correlation between ' headers{j} ...
        ' and DFA of Corresponding Elicited Cortical Activity' ...
        ' Per Frequency Band'];
    set(0, 'currentfigure', eval(['f' num2str(j)]));
    axes('Position', [0.25 -0.025 0.5 1], 'Xlim', [0 1], 'Ylim', [0 1], ...
        'Box', 'off', 'Visible', 'off', 'Units', 'normalized', ...
        'clipping' , 'off');
    text(0.5, 1, headerString, 'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'top', 'FontWeight', 'bold');
end
end