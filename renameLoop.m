function renameLoop( dataDir )              % 'E:\Thomas\Data'
% Loop conditionRename.m to change all Net Station output file names to NBT
% format. See help conditionRename for information.

dirNames        = dir(dataDir);

for i = 1:length(dirNames)
    try
        if dirNames(i).name(1:6) == 'MP14.S'    % Check for data folder
            conditionRename([ dataDir '\' dirNames(i).name ])
        end
    catch err
    end
end
end