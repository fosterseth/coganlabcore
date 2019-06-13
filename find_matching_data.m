function data = find_matching_data(Subject, CondParams, AnalParams)

if ~exist('c:/matlab/workspace/.tmp', 'dir')
    mkdir('c:/matlab/workspace/.tmp');
end

stru1.Subject = Subject;
stru1.CondParams = CondParams;
stru1.AnalParams = AnalParams;

files = dir(fullfile('c:/matlab/workspace/.tmp', sprintf('%s*_params.mat', Subject.Name)));
data = [];
for f = 1:numel(files)
    load(fullfile('c:/matlab/workspace/.tmp', files(f).name));
    stru_o = stru;
    stru = rmfield(stru, 'data_filename');
    if isequaln(stru, stru1)
        data = load(fullfile('c:/matlab/workspace/.tmp', stru_o.data_filename));
        return;
    end
end
end