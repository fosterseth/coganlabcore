function experiment = load_experiment(subject)
e = load(fullfile(get_subject_path(subject), 'mat', 'experiment.mat'));
experiment = e.experiment;