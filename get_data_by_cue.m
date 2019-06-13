function data = get_data_by_cue(subject, condition, cue, epoch)
%e.g. get_data_by_cue(7, 'Go', [-250 500]);
Trials = get_mat(subject, 'struct_trials');
load(fullfile(get_subject_path(subject), 'mat', 'experiment.mat'));
num_channels = numel(experiment.channels);
filename = fullfile(get_subject_path(subject), '010117', '001', sprintf('D%d_010117.ieeg.dat', subject));
data = {};
i = 1;
for t = 1:numel(Trials)
    if Trials(t).StartCode == condition
        tbeg = floor((Trials(t).(cue) + epoch(1) * 30) / 15);
        tend = floor((Trials(t).(cue) + epoch(2) * 30) / 15);
        data{i,1} = read_ieeg(filename, num_channels, tbeg, tend);
        i = i + 1;
    end
end
end