function list_mats(subject)
mat_files = dir(fullfile(get_subject_path(subject), 'mat', '*.mat'));
for m = 1:numel(mat_files)
    fprintf('%s\n', mat_files(m).name);
end