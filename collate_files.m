function collate_files(filenames, directory)
if ~exist(directory, 'dir')
    mkdir(directory)
else
    warning('directory already exists');
    return;
end
for i = 1:numel(filenames)
    copyfile(filenames{i}, directory);
end
end