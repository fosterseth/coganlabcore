function IEEG = load_data(subject, conditions, cue, epoch)

global DUKEDIR;
DUKEDIR= 'c:/matlab/data';
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
    end

Subject.Name = sprintf('D%d', subject);
load([DUKEDIR '/' Subject.Name '/mat/experiment.mat']);
Subject.Experiment = experiment;
Subject.Trials = dbTrials(Subject.Name, '010117');

AnalParams.ReferenceChannels = channels;
AnalParams.Channel = channels;
AnalParams.TrialPooling = 0; % used to be 1

CondParams.PropertyName = {'Noisy', 'NoResponse'};
CondParams.PropertyValue = {0, 0};
CondParams.Field = cue;
CondParams.Conds = conditions;
CondParams.bn = epoch;

% This handles Trials in Subject.Trials and same for experiment.
if isfield(Subject, 'Trials')
    Trials = Subject.Trials;
else
    Trials = dbTrials(Subject.Name,Subject.Day);
end
% UNCOMMENT THIS PART
% if isfield(Subject, 'Experiment')
%     experiment = Subject.Experiment;
% else
%     experiment = loadExperiment(Subject.Name);
% end

Trials = Params2Trials(Trials,CondParams);
whos Trials

sampling = experiment.processing.ieeg.sample_rate;
channels = experiment.channels;
[Channel_names{1:length(channels)}] = deal(channels.name);

if ischar(AnalParams.Channel)
    [dum,Ch] = intersect(Channel_names,AnalParams.Channel);
elseif iscell(AnalParams.Channel)
    Ch = zeros(1,length(AnalParams.Channel));
    for iCh = 1:length(AnalParams.Channel)
        [dum,Ch(iCh)] = intersect(Channel_names,AnalParams.Channel{iCh});
    end
else
    Ch = AnalParams.Channel;
end

% disp(['Calculating spectrum with N = ' ...
%     num2str(N) ' and W = ' num2str(W)]);
bn = epoch;
Field = CondParams.Field;

IEEG = trialIEEG(Trials, Ch, Field, bn);
end