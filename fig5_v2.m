function fig5_v2
% pwd = I:\Plots - Compare Biomarker\crop

figures = dir([pwd '\*.tif']);

f1 = figure;
f3 = figure;

imgTitles = {'Norm. Amplitude in 1-4 Hz Band'; 'Norm. Amplitude in 4-8 Hz Band'; 'Norm. Amplitude in 8-13 Hz Band'; ...
    'Norm. Amplitude in 13-30 Hz Band'; 'Norm. Amplitude in 30-45 Hz Band'; 'Norm. Amplitude in 55-125 Hz Band'; ...
    'Norm. Amplitude in 60-90 Hz Band'};
headers = {'Focus'; 'Eyes Open/Closed'; 'Familiarity'; 'Loudness Amplitude'; ...
    'Pitch Amplitude'; 'Pleasurability'; 'Rhythm Amplitude'; 'RPL Amplitude'};

for i = 1:7
    % Concentratedness
    set(0, 'currentfigure', f1);
    s1 = subplot(1, 7, i);
    img = imread(figures(i + 7).name);
    imshow(img);
    title(imgTitles{i});
    hold on
    
%     % Eyes
%     set(0, 'currentfigure', f2);
%     s2 = subplot(1, 7, i);
%     img = imread(figures(i + 7 * 1).name);
%     imshow(img);
%     title(imgTitles{i});
%     hold on
    
    % Familiarity
    set(0, 'currentfigure', f3);
    s3 = subplot(1, 7, i);
    img = imread(figures(i).name);
    imshow(img);
    title(imgTitles{i});
    hold on
    
%     % Loudness DFA
%     set(0, 'currentfigure', f4);
%     s4 = subplot(1, 7, i);
%     img = imread(figures(i + 7 * 3).name);
%     imshow(img);
%     title(imgTitles{i});
%     hold on
%     
%     % Pitch DFA
%     set(0, 'currentfigure', f5);
%     s5 = subplot(1, 7, i);
%     img = imread(figures(i + 7 * 4).name);
%     imshow(img);
%     title(imgTitles{i});
%     hold on
%     
%     % Pleasure
%     set(0, 'currentfigure', f6);
%     s6 = subplot(1, 7, i);
%     img = imread(figures(i + 7 * 5).name);
%     imshow(img);
%     title(imgTitles{i});
%     hold on
%     
%     % Rhythm DFA
%     set(0, 'currentfigure', f7);
%     s7 = subplot(1, 7, i);
%     img = imread(figures(i + 7 * 6).name);
%     imshow(img);
%     title(imgTitles{i});
%     hold on
%     
%     % RPL DFA
%     set(0, 'currentfigure', f8);
%     s8 = subplot(1, 7, i);
%     img = imread(figures(i + 7 * 7).name);
%     imshow(img);
%     title(imgTitles{i});
%     hold on
    
end

%    Titles
for j = 1:2:3
    headerString = ['Spearman Correlation between ' headers{j} ...
        ' and Amplitude of Corresponding Elicited Cortical Activity' ...
        ' Per Frequency Band'];
    set(0, 'currentfigure', eval(['f' num2str(j)]));
    axes('Position', [0.25 -0.025 0.5 1], 'Xlim', [0 1], 'Ylim', [0 1], ...
        'Box', 'off', 'Visible', 'off', 'Units', 'normalized', ...
        'clipping' , 'off');
    text(0.5, 1, headerString, 'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'top', 'FontWeight', 'bold');
end
end