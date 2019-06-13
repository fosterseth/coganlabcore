clear;
global globalFsDir;
cfg = [];
cfg.rmDepths = 0;
cfg.avgsubj = 'fsaverage'; %fsaverage
cfg.plotEm = 0;

avg_subj_list = fullfile(globalFsDir, cfg.avgsubj, 'list.subjects.txt');
if exist(fullfile(globalFsDir, cfg.avgsubj, 'list.subjects.txt'), 'file')
    fid = fopen(avg_subj_list, 'r');
    sublist = textscan(fid, '%s');
    fclose(fid);
    fprintf('%s is an average of the following subjects\n', cfg.avgsubj);
    for s = 1:numel(sublist{1})
        fprintf('\t%s\n',sublist{1}{s});
    end
end

subs = {
    'D13'
    'D14'
    'D15'
    'D16'
    'D17'
    };

groupAvgCoords = [];
groupLabels = [];
groupIsLeft = [];
load colors.mat;
color = [];
for d = 1:numel(subs)
    [avgCoords,elecNames,isLeft] = sub2AvgBrain(subs{d}, cfg);
    groupAvgCoords = [groupAvgCoords; avgCoords];
    groupLabels = [groupLabels; elecNames];
    groupIsLeft = [groupIsLeft; isLeft];
    fprintf('%s %d\n', subs{d}, numel(elecNames));
    color = cat(1, color, repmat(colors(d,:), numel(elecNames), 1));
end

if 1 % for custom grouping colors
    load group_onset_coded;
    brainid = 5;
    grouping.idx = grouping.idx(:,brainid);
    grouping.colors = squeeze(grouping.colors(:,:,brainid));
    if iscell(grouping.idx)
        grouping.idx = grouping.idx{1};
    end
    
%     grouping.colors = colors([1 4],:); % task
    
    if isfield(grouping, 'colors') && ~isempty(grouping.colors)
        colors = grouping.colors;
    end
    
    if isfield(grouping, 'color_labels') && ~isempty(grouping.color_labels)
        color_labels = grouping.color_labels;
    else
        color_labels = arrayfun(@num2str, 1:size(colors,1), 'un', 0);
    end
    legendf(color_labels, colors);
    mask_to_show = zeros(numel(groupLabels), 1);
    color = zeros(numel(groupLabels), 3);
    for c = 1:numel(grouping.labels)
        idx = find(strcmp(groupLabels, grouping.labels{c}), 1, 'first');
        if ~isempty(idx)
            if grouping.idx(c) == 0 % then don't show electrode
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



plot_surf;

hold on;
mask_to_show = mask_to_show == 1;

if 0 % to only show one hemisphere
    one_hem_mask = contains(groupLabels, '-R');
    mask_to_show = mask_to_show & one_hem_mask;
end

scatter3(groupAvgCoords(mask_to_show,1), groupAvgCoords(mask_to_show,2), groupAvgCoords(mask_to_show,3), 200, color(mask_to_show,:), 'filled');

if 1 % for electrode labels
    for e = 1:numel(groupLabels)
        if mask_to_show(e) == 1
            text(groupAvgCoords(e,1), groupAvgCoords(e,2), groupAvgCoords(e,3), groupLabels{e}, 'fontsize', 10);
        end
    end
end