clear;
Recon_root = 'C:/users/sf225/Google Drive/D_Data';

subs = {
    'D13'
    'D14'
    'D15'
    'D17'
    'D16'
    };

groupAvgCoords = [];
groupLabels = [];
groupIsLeft = [];
load colors.mat;
color = [];
for d = 1:numel(subs)
    cinfo = load(fullfile(Recon_root, subs{d}, 'Recon', 'coordsfsaverage.mat'));
    groupAvgCoords = [groupAvgCoords; cinfo.coordsfsaverage.avgCoords];
    groupLabels = [groupLabels; cinfo.coordsfsaverage.elecNames];
    groupIsLeft = [groupIsLeft; cinfo.coordsfsaverage.isLeft];
    color = cat(1, color, repmat(colors(d,:), numel(cinfo.coordsfsaverage.elecNames), 1));
end


if 0 % for custom grouping colors
    load groupingBeta2.mat;
    grouping.colors = colors(3:6,:);
    if isfield(grouping, 'colors') && ~isempty(grouping.colors)
        colors = grouping.colors;
    end
    mask_to_show = zeros(numel(groupLabels), 1);
    color = zeros(numel(groupLabels), 3);
    for c = 1:numel(grouping.labels)
        idx = find(strcmp(groupLabels, grouping.labels{c}), 1, 'first');
        if ~isempty(idx)
            if grouping.idx(idx) == 0 % then don't show electrode
                mask_to_show(idx,1) = 0;
                color(idx,:) = [0 0 0];
            else
                mask_to_show(idx,1) = 1;
                color(idx, :) = colors(grouping.idx(c), :);
            end
        end
    end
else
    mask_to_show = ones(numel(groupLabels), 1);
end


plot_surf_pial;

hold on;
mask_to_show = mask_to_show == 1;
scatter3(groupAvgCoords(mask_to_show,1), groupAvgCoords(mask_to_show,2), groupAvgCoords(mask_to_show,3), 200, color(mask_to_show,:), 'filled');

if 0
    for e = 1:numel(groupLabels)
        if mask_to_show(e) == 1
            text(groupAvgCoords(e,1), groupAvgCoords(e,2), groupAvgCoords(e,3), groupLabels{e}, 'fontsize', 10);
        end
    end
end