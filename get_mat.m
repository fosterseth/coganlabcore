function data = get_mat(subject, dataname)
load(fullfile(get_subject_path(subject), 'mat', [dataname '.mat']));
data = sdata.data;
end