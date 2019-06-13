function list_subjects()
folder_names = dir(get_root_path);
for f = 1:numel(folder_names)
    if folder_names(f).name(1) == 'D'
        fprintf('%s\n', folder_names(f).name);
    end
end
end