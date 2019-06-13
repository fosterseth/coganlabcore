function rootpath = get_subject_path(subject)
dataroot = get_root_path();
rootpath = fullfile(dataroot, sprintf('d%d/', subject));
end