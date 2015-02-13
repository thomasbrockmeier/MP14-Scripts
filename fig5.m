function fig5

figures = dir([pwd '*.tif']);
for i = 1:7
    % Concentratedness
    s1 = subplot(1, 7, i);
    img = imread(figures(i).name);
    hold on
    
    % Eyes
    s2 = subplot(1, 7, i);
    img = imread(figures(i + 7 * 1).name);
    hold on
    
    % Familiarity
    s3 = subplot(1, 7, i);
    img = imread(figures(i + 7 * 2).name);
    hold on
    
    % Loudness DFA
    s4 = subplot(1, 7, i);
    img = imread(figures(i + 7 * 3).name);
    hold on
    
    % Pitch DFA
    s5 = subplot(1, 7, i);
    img = imread(figures(i + 7 * 4).name);
    hold on
    
    % Pleasure
    s6 = subplot(1, 7, i);
    img = imread(figures(i + 7 * 5).name);
    hold on
    
    % Rhythm DFA
    s7 = subplot(1, 7, i);
    img = imread(figures(i + 7 * 6).name);
    hold on
    
    % RPL DFA
    s8 = subplot(1, 7, i);
    img = imread(figures(i + 7 * 7).name);
    hold on
    
end
end