function conditionRename( subjectDir )
% Renames files from Net Station to NBT format (for project MP14).
% N.B., MAKE SURE THAT THE CONTENTS OF THE INPUT FOLDER ARE BACKED UP
%       BEFORE RUNNING THIS SCRIPT!
%
%   Input:
%       subjectDir: Folder containing .raw files (Net Station export of EEG
%                   recordings) and .xlsx file (converted from Open Sesame
%                   .csv output).
%
%                   subjectDir needs to be in NBT format, e.g.:
%                   E:\Thomas\Data\MP14.S0001.141114
%               
%                   .xlsx file needs to be in NBT format, e.g.:
%                   E:\Thomas\Data\MP14.S0001.141114.xlsx
%
%   Output:
%        None. The files in subjectDir are renamed, and a changelog is
%        generated in the same directory.
%
%       N.B., The file names are expected to be numbered in chronological 
%       order by the Net Station output (EGI2RAW) function!
%
%       (c) 2014 - Thomas Brockmeier

% Get directory information, and load .xlsx file
fileNames           = dir([subjectDir, '\*.raw']);
xlsxFind            = [subjectDir, '\*.xlsx'];
dataFile            = dir(xlsxFind);
[ ~, fileName, ~ ]  = fileparts(dataFile.name);
dataFile            = importdata([subjectDir, '\', dataFile.name]);

% Create .log file
fileID = fopen(['changelog.' subjectDir '\' fileName '.log'], 'w');

% Get song codes (conditions) from file, generate file name in NBT format, 
% and rename files
for i = 1:length(fileNames)
    
    if i == 1       % Eyes Closed Rest
        newName     = [fileName, '.ECR.raw'];
    elseif i == 2   % Test Trial
        newName     = [fileName, '.TST.raw'];
    elseif i >= 3   % Experimental trials
        row = 67 + 5 * (i - 3);
        condition   = strrep(dataFile{row}, '"','');
        condition   = condition(16:19);
        
        if i >= 3 && i < 15     % Regular trials
            newName     = [fileName, '.', condition, '.raw'];
        elseif i >= 15          % Repeated trials
            newName     = [fileName, '.', condition, 'R.raw'];
        end
        
        newName(21) = [];
    end
    
    % Rename file, print status, and write .log file of changes to
    % directory
    movefile([subjectDir '\' fileNames(i).name], [subjectDir '\' newName]);
    fprintf('Converting %s to %s...\n', fileNames(i).name, newName);
    %fprintf(fileID, 'Converted %s to %s...\r\n', fileNames(i).name, newName);
end

%fclose(fileID);
end