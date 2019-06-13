clear;
global globalFsDir;
cfg = [];
sub = 'D16';
hem = 'l';
flag_print = 0;
cfg.opaqueness = 1;
cfg.title = 'D16';
cfg.ignoreDepthElec = 'n';
cfg.elecCbar = 'n';

cfg.showLabels = 'n';

elec_data = scantext(fullfile(globalFsDir, sub, 'elec_recon', [sub '_elec_locations_RAS.txt']), ' ', 0, '%s %s %f %f %f %s %s');
elec_areas = unique(elec_data{1});
elecNames = elec_data([1 2]);
elecNames = strcat(elecNames{1}, elecNames{2});
ras_coor = elec_data([3,4,5]);
ras_coor = horzcat(ras_coor{:});

load('colors.mat');
colors2= [];
for i = 1:numel(elec_data{1})
    idx = find(ismember(elec_areas, elec_data{1}{i}), 1, 'first');
    colors2 = cat(1, colors2, colors(idx,:));
end
cfg.elecColors = colors2;
cfg.elecColorScale = [1 size(colors2, 1)];

cfg.showLabels = 'n';
% cfg.overlayParcellation = 'DK';
cfg.olayCbar ='n';
if isfield(cfg, 'overlayParcellation')
    overlay = cfg.overlayParcellation;
else
    overlay = '';
end

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


if strcmp(sub, 'D16_old')
    views = views([5 9 1]);
    map_from = flipud(reshape(1:28, 4, 7)); % create matrix of the natural order electrodes are plotted
    map_to = reshape(1:28, 7,4)'; % create a matrix of the order in which the electrode should be plotted (indices)
    newElecNames = {};
    for e = 1:numel(map_from)
        idx = find(map_from == e);
        newElecNames{e} = elecNames{map_to(idx)};
    end
    elecNames(1:numel(newElecNames)) = newElecNames;
    only_label = {
        arrayfun(@(a) sprintf('LTG%d', a), [34 40 42 50 58 64], 'un', 0);
        arrayfun(@(a) sprintf('LAST%d', a), [1 4], 'un', 0);
        arrayfun(@(a) sprintf('LMST%d', a), [1 4], 'un', 0);
        arrayfun(@(a) sprintf('LPST%d', a), [1 6], 'un', 0);};
    
    only_label = horzcat(only_label{:});
else
    only_label = elecNames;
end
for v = 1:numel(views)
%     close all;
    cfg.view = sprintf('%s%s', hem, views{v}{1});
    cfgout = plotPialSurf(sub, cfg);
    
    for e = 1:numel(elecNames)
        if ismember(elecNames{e}, only_label)
            x = campos - cfgout.electrodeCoords(e,:);
            x = (x ./norm(x)) * 12;
            y = cfgout.electrodeCoords(e,:) + x;
            text(y(1), y(2), y(3), elecNames{e}, 'fontsize', 12);
        end
    end
    h = gcf;
    h.Position = [0 0 1920 1080];
    if flag_print
        export_fig(gcf, fullfile(globalFsDir, sub, 'elec_recon', 'PICS', sprintf('%s_%s_%s_%s', sub, hem, views{v}{2}, overlay)), '-dpng', '-r300');
    end
end