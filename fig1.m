function fig1()

load('E:\Thomas\Data\Music Analysis\intervals_noteDurs_monoAmps.mat')
segments = ['BH1'; 'BH2'; 'BR1'; 'BR2'; 'CH1'; 'CH2'; 'GR1'; 'GR2'; ...
    'HD1'; 'HD2'; 'MZ1'; 'MZ2'];

targetSegments = [10 1 7];

fontSize = 10;
mult     = 2.5;
f = figure('units', 'inches', 'position', [0 0 (mult * 4) (mult * 3)]);

% High pitch interval DFA
subplot(3, 3, 1:2);
plot(eval(['intervals' segments(targetSegments(1), :)]))
set(gca, 'Fontsize', fontSize)
axis([0 500 0 60])
xlabel('Successive Interval', 'Fontsize', fontSize)
ylabel('Note Interval (Semitones)', 'Fontsize', fontSize)
% xlim([0 length(eval(['intervals' segments(targetSegments(1), :)]))])
title('Successive Pitch Intervals for a High DFA Piece (HD2)', 'Fontsize', fontSize)

h = subplot(3, 3, 3);
p = get(h, 'position');
p(1) = p(1) + 0.02;
compDFA(eval(['intervals' segments(targetSegments(1), :)]), 10, 1)
set(gca, 'Fontsize', fontSize, 'position', p)
xlabel('log_{10}(interval), [Successive Intervals]', 'Fontsize', fontSize)
ylabel('log_{10} F(interval)', 'Fontsize', fontSize)

% Mid pitch interval DFA
subplot(3, 3, 4:5);
plot(eval(['intervals' segments(targetSegments(2), :)]))
set(gca, 'Fontsize', fontSize)
axis([0 500 0 60])
xlabel('Successive Interval', 'Fontsize', fontSize)
ylabel('Note Interval (Semitones)', 'Fontsize', fontSize)
% xlim([0 length(eval(['intervals' segments(targetSegments(2), :)]))])
title('Successive Pitch Intervals for a Medium DFA Piece (BH1)', 'Fontsize', fontSize)

h = subplot(3, 3, 6);
p = get(h, 'position');
p(1) = p(1) + 0.02;
compDFA(eval(['intervals' segments(targetSegments(2), :)]), 10, 1)
set(gca, 'Fontsize', fontSize, 'position', p)
xlabel('log_{10}(interval), [Successive Intervals]', 'Fontsize', fontSize)
ylabel('log_{10} F(interval)', 'Fontsize', fontSize)

% Low pitch interval DFA
subplot(3, 3, 7:8);
plot(eval(['intervals' segments(targetSegments(3), :)]))
set(gca, 'Fontsize', fontSize)
axis([0 500 0 60])
xlabel('Successive Interval', 'Fontsize', fontSize)
ylabel('Note Interval (Semitones)', 'Fontsize', fontSize)
% xlim([0 length(eval(['intervals' segments(targetSegments(3), :)]))])
title('Successive Pitch Intervals for a Low DFA Piece (GR1)', 'Fontsize', fontSize)

h = subplot(3, 3, 9);
p = get(h, 'position');
p(1) = p(1) + 0.02;
compDFA(eval(['intervals' segments(targetSegments(3), :)]), 10, 1)
set(gca, 'Fontsize', fontSize, 'position', p)
xlabel('log_{10}(interval), [Successive Intervals]', 'Fontsize', fontSize)
ylabel('log_{10} F(interval)', 'Fontsize', fontSize)

%    Title
headerString = ['Pitch Contours for the First 500 Intervals in High, Middle, and Low DFA Pieces (left, top to bottom)' ...
    sprintf('\n') 'and Corresponding DFA plots (right, top to bottom; computed over the full segment)'];
axes('Position', [0 0 1 1], 'Xlim', [0 1], 'Ylim', [0 1], 'Box', ...
    'off', 'Visible', 'off', 'Units', 'normalized', 'clipping' , 'off');
text(0.5, 1, headerString, 'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'top', 'FontWeight', 'bold', 'Fontsize', fontSize);

end