function dicom_filter_by_series(dicom_dir)

dnames = dir(fullfile(dicom_dir, '*.dcm'));
to_process = {};
to_reject = {};
for d = 1:numel(dnames)
    src = fullfile(dicom_dir, dnames(d).name);
    dinfo = dicominfo(src);

    SD = sprintf('%s_%d', dinfo.SeriesDescription, dinfo.SeriesNumber);
    dest = fullfile(dicom_dir, SD);
    if ~exist(dest, 'dir') && sum(strcmp(to_reject, dest)) == 0
        i = input(sprintf('copy series %s y or n? ', dest), 's');
        if strcmp(i, 'y') || strcmp(i, 'yes') || strcmp(i, '1')
            to_process = cat(1, to_process, {dest});
            mkdir(dest);
        else
            to_reject = cat(1, to_reject, {dest});
        end
    end
    if sum(strcmp(to_process, dest)) > 0
        copyfile(src, dest);
    end
end
end