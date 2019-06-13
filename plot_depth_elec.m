close all;
cfg = [];
flag_print = 1;
subj_folder = 'D9';
switch subj_folder
    case 'D14'
        hem = 'r';
    case 'D17'
        hem = 'l'; % elec in both
    case 'D9'
        hem = 'r';
end
cfg.opaqueness = .3;
cfg.title = subj_folder;
cfg.ignoreDepthElec = 'n';
load('colors.mat');
sensor_sizes = ones(1,12) * 10; 
colors2= [];
for i = 1:numel(sensor_sizes)
colors2 = cat(1, colors2, repmat(colors(i,:), sensor_sizes(i),1));
end
cfg.elecColors = colors2;
cfg.elecColorScale = [1 sum(sensor_sizes)];
cfg.showLabels = 'y';


views = {
    {'', 'hem_lateral'}
    {'m', 'hem_medial'}
    {'o', 'hem_occipital'}
    {'f', 'hem_frontal'}
    {'im', 'hem_inferior-medial'}
    {'i', 'hem_inferior'}
    {'s', 'hem_superior'}
    {'sv', 'hem_superior_vert_aligned'}
    {'iv', 'hem inferior_vert_aligned'}
    };
% cfg.overlayParcellation = 'D';
for v = 1:numel(views)
    cfg.view = sprintf('%s%s', hem, views{v}{1});
    plotPialSurf(subj_folder, cfg);
%     f = gcf;
%     f.Position = [0 0 1920 1080];
    if flag_print
        print(sprintf('%s_%s_%s', cfg.title, hem, views{v}{2}), '-dpng', '-r300');
    end
end


