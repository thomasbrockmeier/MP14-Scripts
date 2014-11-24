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
%                   E:\Thomas\Data\MP14.S0001.20141114
%               
%                   .xlsx file needs to be in NBT format, e.g.:
%                   E:\Thomas\Data\MP14.S0001.20141114.xlsx
%
%                       This file has to be converted manually from the
%                       .csv output from Open Sesame...
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
dataFile            = dir([subjectDir, '\*.xlsx']);
dataFileImport      = importdata([subjectDir, '\', dataFile.name]);
[ ~, fileName, ~ ]  = fileparts(dataFile.name);

% Create .log file
fileID = fopen([subjectDir '\' fileName '.changelog.log'], 'w');

% Remove invisible files from fileNames
for i = length(fileNames):-1:1
    if fileNames(i).name(1) == '.';
        fileNames(i) = [];
    end
end

% Get song codes (conditions) from file, generate file name in NBT format, 
% and rename files
for ii = 1:length(fileNames)
    
    if ii == 1       % Eyes Closed Rest
        newName     = [fileName, '.ECR.raw'];
    elseif ii == 2   % Test Trial
        newName     = [fileName, '.TST.raw'];
    elseif ii >= 3   % Experimental trials
        row = 67 + 5 * (ii - 3);
        condition   = strrep(dataFileImport{row}, '"','');
        condition   = condition(16:19);
        
        if ii >= 3 && ii < 15     % Regular trials
            newName     = [fileName, '.', condition, '.raw'];
        elseif ii >= 15          % Repeated trials
            newName     = [fileName, '.', condition, 'R.raw'];
        end
        
        newName(23) = [];
    end
    
    % Rename file, print status, and write .log file of changes to
    % directory
    movefile([subjectDir '\' fileNames(ii).name], [subjectDir '\' newName]);
    fprintf('Converting %s to %s...\n', fileNames(ii).name, newName);
    fprintf(fileID, 'Converted %s to %s...\r\n', fileNames(ii).name, newName);
end

fclose(fileID);
end