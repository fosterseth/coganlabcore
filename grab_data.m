function [Spec_cat,Trials, Subject, AnalParams, CondParams] = grab_data(subject, conditions, cue, epoch)
% returns channels x trials x time x frequency
% global DUKEDIR;
% DUKEDIR= 'c:/matlab/data';
AnalParams.Tapers = [.5,10];
AnalParams.fk = [0 250];
AnalParams.Reference = 'Grand average';
AnalParams.ArtifactThreshold =12; % Used to be 8
AnalParams.pad=2;
    switch subject
        case 7
            channels = 17:80;
        case 3

            channels = setdiff(1:32, 12);
        case 5

            channels = 94:121;
        case 11

            channels = setdiff(24:87, [46 66]);
            
        case 14
            channels = 10:129;
            
        case 15
            channels = 10:129;
            
        case 23
            channels = 1:122;
        otherwise
            error('Subject not listed in switch block');
    end

Subject.Name = sprintf('D%d', subject);
Subject.Experiment = loadExperiment(Subject.Name);
Subject.Trials = dbTrials(Subject.Name, '010117');
global experiment;
experiment=Subject.Experiment;


AnalParams.ReferenceChannels = channels;
AnalParams.Channel = channels;
AnalParams.TrialPooling = 0; % used to be 1

CondParams.PropertyName = {'Noisy', 'NoResponse'};
CondParams.PropertyValue = {0, 0};
CondParams.Field = cue;
CondParams.Conds = conditions;
CondParams.bn = epoch;

data = find_matching_data(Subject, CondParams, AnalParams);
if ~isempty(data) && isfield(data, 'data')
    Spec_cat = data.data.Spec_cat;
    Trials = data.data.Trials;
else
    [Spec,~, Trials] = subjSpectrum(Subject, CondParams, AnalParams);

    Spec_cat = zeros([numel(Spec) size(Spec{1})]);
    for s = 1:numel(Spec)
        Spec_cat(s,:,:,:) = Spec{s};
    end
    save_tmp_data(Subject, CondParams, AnalParams, Spec_cat, Trials);
end