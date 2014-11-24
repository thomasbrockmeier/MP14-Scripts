plot(rhythmDFA, pitchDFA, 'bo')
xlabel('rhythmDFA')
ylabel('pitchDFA')
title('Scatter Plot of All (283) Rhythm and Pitch DFAs in Set')

%%%%%%%%%%%%%%%%

plot(rhythmDFA_BH, pitchDFA_BH, 'bo')
hold on
plot(rhythmDFA_CH, pitchDFA_CH, 'k.')
hold on
plot(rhythmDFA_GR, pitchDFA_GR, 'rp')
hold on
plot(rhythmDFA_HD, pitchDFA_HD, 'md')
hold on
plot(rhythmDFA_MZ, pitchDFA_MZ, 'c*')
hold on
plot(rhythmDFA_SB, pitchDFA_SB, 'gs')
legend('Beethoven; R = 0.46, p = 2.20 * 10^7', ...
       'Chopin; R = 0.23, p = 0.10', ...
       'Grieg; R = 0.47, p = 0.42', ...
       'Haydn; R = 0.49, p = 0.02', ...
       'Mozart; R = 0.18, p = 0.11', ...
       'Schubert; R = 0.00, p = 1.00', ...
       'Location', 'NorthWest')
xlabel('rhythmDFA')
ylabel('pitchDFA')
title({'Scatter Plot of All (283) Rhythm and Pitch DFAs in Set By Composer'; ...
       'R: Pearson''s linear correlation coefficient';})
annotation('textbox', [0.0,0.0,0.0,0.0],...
           'String', 'Correlation coefficient of all compositions combined: R = 0.53, p = 1.32 * 10^21');
       
%%%%%%%%%%%%%%%%%%%%%%%
       
x1 = ones(length(rhythmDFA), 1) * 0.25;
x2 = ones(length(pitchDFA), 1) * 0.75;
y1 = rhythmDFA;
y2 = pitchDFA;
jitterValuesX = 2*(rand(size(x1))-0.5)*0.1;
plot(x1 + jitterValuesX, y1, 'b.')
hold on
plot(x2 + jitterValuesX, y2, 'r.')
axis([0 1 floor(min(y1)) ceil(max(y1))]);
ylabel('DFA (beta)')
title('Distribution of DFA Values for Rhythm and Pitch')