function trials = load_trials(subject)
experiment = load_experiment(subject);
t = load(fullfile(get_subject_path(subject), experiment.recording.recording_day, 'mat', 'Trials.mat'));
trials = t.Trials;
end