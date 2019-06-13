function save_tmp_data(Subject, CondParams, AnalParams, Spec_cat, Trials)

if ~exist('c:/matlab/workspace/.tmp', 'dir')
    mkdir('c:/matlab/workspace/.tmp');
end

stru.Subject = Subject;
stru.CondParams = CondParams;
stru.AnalParams = AnalParams;
c = clock();
fn = sprintf('%s_%d%d%d%d%d%d', Subject.Name, c(1), c(2), c(3), c(4), c(5), floor(c(6)));
stru.data_filename = [fn '_data.mat'];
save(fullfile('c:/matlab/workspace/.tmp', [fn '_params.mat']), 'stru');
data.Spec_cat = Spec_cat;
data.Trials = Trials;
save(fullfile('c:/matlab/workspace/.tmp', stru.data_filename), 'data');

end