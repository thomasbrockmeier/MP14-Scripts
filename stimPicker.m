function output = stimPicker(input)

structure = input;
composers = fieldnames(structure);

highRDFA_highPDFA = cell(1, 7);
highRDFA_lowPDFA  = cell(1, 7);
lowRDFA_highPDFA  = cell(1, 7);
lowRDFA_lowPDFA   = cell(1, 7);

expR_means = zeros(length(composers), 1);
expP_means = zeros(length(composers), 1);
nComps     = zeros(length(composers), 1);

for i = 1:length(composers)
    expR_means(i) = structure.(composers{i}).DFA{2, 9};
    expP_means(i) = structure.(composers{i}).DFA{4, 9};
    fileDir       = strcat('E:\Thomas\MIDI\', composers{i}, '\');
    files         = dir(fileDir);
    files([1 2])  = [];
    nComps(i)     = length(files);
    
    expR_means(i) = expR_means(i) * nComps(i);
    expP_means(i) = expP_means(i) * nComps(i);
end

mean_expR = sum(expR_means) / sum(nComps);
mean_expP = sum(expP_means) / sum(nComps);

for ii = 1:length(composers)
    highRDFA_highPDFA{end + 1, 1} = composers{ii};
    highRDFA_lowPDFA{end + 1, 1}  = composers{ii};
    lowRDFA_highPDFA{end + 1, 1}  = composers{ii};
    lowRDFA_lowPDFA{end + 1, 1}   = composers{ii};
    
    compositions = structure.(composers{ii}).DFA;
    for jj = 2:size(compositions, 1)
        expR = compositions{jj, 2};
        expP = compositions{jj, 5};
        
        if ~isempty(compositions{jj, 1}) 
            if expR > mean_expR && expP > mean_expP
                highRDFA_highPDFA(end + 1, 1:7) = compositions(jj, 1:7);
            elseif expR > mean_expR && expP < mean_expP
                highRDFA_lowPDFA(end + 1, 1:7) = compositions(jj, 1:7);
            elseif expR < mean_expR && expP > mean_expP
                lowRDFA_highPDFA(end + 1, 1:7) = compositions(jj, 1:7);
            elseif expR < mean_expR && expP < mean_expP
                lowRDFA_lowPDFA(end + 1, 1:7) = compositions(jj, 1:7);
            end
        end
    end
end

output = cell(4, 2);
output{1, 1} = 'highRDFA_highPDFA';
output{2, 1} = 'highRDFA_lowPDFA';
output{3, 1} = 'lowRDFA_highPDFA';
output{4, 1} = 'lowRDFA_lowPDFA';

output{1, 2} = highRDFA_highPDFA;
output{2, 2} = highRDFA_lowPDFA;
output{3, 2} = lowRDFA_highPDFA;
output{4, 2} = lowRDFA_lowPDFA;

fprintf('\n')
fprintf('Weighted mean rhythm scaling exponent: %.4f\n', mean_expR)
fprintf('Weighted mean pitch scaling exponent: %.4f\n', mean_expP)

end