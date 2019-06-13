function record_mat(subject, dataname, data)
sdata.data = data;
save(fullfile(get_subject_path(subject), 'mat', [dataname '.mat']), 'sdata');
end