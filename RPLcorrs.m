% Ordered alphabetically cf. stimulus names: BH1; BH2 ... MZ1; MZ2

rhythmDFA = [0.60; 0.73; 0.85; 1.06; 0.58; 0.90; 0.59; 0.85; 1.00; ...
    1.06; 0.78; 0.99];
pitchDFA = [0.72; 0.53; 0.73; 0.89; 0.51; 0.56; 0.71; 0.56; 0.78; 0.90; ...
    0.73; 0.78];
lnessDFA = [0.91; 1.11; 1.00; 1.15; 0.95; 0.91; 1.05; 1.04; 1.09; 1.24; ...
    1.08; 1.04];
labels = ['BH1'; 'BH2'; 'BR1'; 'BR2'; 'CH1'; 'CH2'; 'GR1'; 'GR2'; 'HD1';...
    'HD2'; 'MZ1'; 'MZ2'];

fontSize = 8;
nTicks = 3;

figure

sp1 = subplot(1, 3, 1);
[r, p] = corr(rhythmDFA, pitchDFA);
str1 = ['r = ' sprintf('%0.2f', r)];
str2 = ['p = ' sprintf('%0.2f', p)];
scatter(rhythmDFA, pitchDFA, '.')
set(sp1, 'XLim', [(min(rhythmDFA) - 0.05) (max(rhythmDFA) + 0.05)], ...
    'YLim', [(min(pitchDFA) - 0.05) (max(pitchDFA) + 0.05)])
a = lsline;
set(a, 'Color', 'r')
xlabel('Rhythm DFA', 'Fontsize', fontSize)
ylabel('Pitch DFA', 'Fontsize', fontSize)
title(sprintf('Linear Correlation Between Stimulus Properties:\nRhythm DFA and Pitch DFA'), 'Fontsize', fontSize)
x = get(sp1, 'XLim');
y = get(sp1, 'YLim');
xmin = x(1) + (x(2) - x(1)) / 10;
ymax = y(2) - (y(2) - y(1)) / 10;
text(xmin, ymax, sprintf('%s\n%s', str1, str2), 'Parent', sp1);
text(rhythmDFA, pitchDFA, labels, 'horizontal', 'left', 'vertical', 'bottom', 'Fontsize', 8)

sp2 = subplot(1, 3, 2);
[r, p] = corr(rhythmDFA, lnessDFA);
str1 = ['r = ' sprintf('%0.2f', r)];
str2 = ['p = ' sprintf('%0.2f', p)];
scatter(rhythmDFA, lnessDFA, '.')
set(sp2, 'XLim', [(min(rhythmDFA) - 0.05) (max(rhythmDFA) + 0.05)], ...
    'YLim', [(min(lnessDFA) - 0.05) (max(lnessDFA) + 0.05)])
a = lsline;
set(a, 'Color', 'r')
xlabel('Rhythm DFA', 'Fontsize', fontSize)
ylabel('Loudness DFA', 'Fontsize', fontSize)
title(sprintf('Linear Correlation Between Stimulus Properties:\nRhythm DFA and Loudness DFA'), 'Fontsize', fontSize)
x = get(sp2, 'XLim');
y = get(sp2, 'YLim');
xmin = x(1) + (x(2) - x(1)) / 10;
ymax = y(2) - (y(2) - y(1)) / 10;
text(xmin, ymax, sprintf('%s\n%s', str1, str2), 'Parent', sp2);
text(rhythmDFA, lnessDFA, labels, 'horizontal', 'left', 'vertical', 'bottom', 'Fontsize', 8)

sp3 = subplot(1, 3, 3);
[r, p] = corr(pitchDFA, lnessDFA);
str1 = ['r = ' sprintf('%0.2f', r)];
str2 = ['p = ' sprintf('%0.2f', p)];
scatter(pitchDFA, lnessDFA, '.')
set(sp3, 'XLim', [(min(pitchDFA) - 0.05) (max(pitchDFA) + 0.05)], ...
    'YLim', [(min(lnessDFA) - 0.05) (max(lnessDFA) + 0.05)])
a = lsline;
set(a, 'Color', 'r')
xlabel('Pitch DFA', 'Fontsize', fontSize)
ylabel('Loudness DFA', 'Fontsize', fontSize)
title(sprintf('Linear Correlation Between Stimulus Properties:\nPitch DFA and Loudness DFA'), 'Fontsize', fontSize)
x = get(sp3, 'XLim');
y = get(sp3, 'YLim');
xmin = x(1) + (x(2) - x(1)) / 10;
ymax = y(2) - (y(2) - y(1)) / 10;
text(xmin, ymax, sprintf('%s\n%s', str1, str2), 'Parent', sp3);
text(pitchDFA, lnessDFA, labels, 'horizontal', 'left', 'vertical', 'bottom', 'Fontsize', 8)