function handle_scatter = plot_elec(elec_filename, flag_show_labels, cfg)
% PLOT_ELEC    plots RAS coordinates of electrodes onto current axes
%     All arguments are optional
%         default_cfg.elec_size = 200;
%         default_cfg.colors = colors; % Nx3 color matrix, one for each depth/grid in elec_filename. Or, 1x3 for single color.
%         default_cfg.font_size = 8;
%         default_cfg.font_color = [1 1 1];
%         default_cfg.label_skip_n = 2; % 2 means only label every other electrode


global recentelecDir;
global RECONDIR;

load colors.mat;
default_cfg.elec_size = 200;
default_cfg.colors = colors; % Nx3 color matrix, one for each depth/grid in elec_filename. Or, 1x3 for single color.
default_cfg.font_size = 8;
default_cfg.font_color = [1 1 1];
default_cfg.label_skip_n = 2; % 2 means only label every other electrode

if nargin < 3
    cfg = default_cfg;
else
    cfg = merge_structs(default_cfg, cfg);
end

if isempty(recentelecDir)
    recentelecDir = '.';
end

if ~isempty(RECONDIR)
    recentelecDir = RECONDIR;
end

if nargin < 2
    flag_show_labels = false;
end

if nargin < 1 || isempty(elec_filename)
    [elec_fn, fpath] = uigetfile(fullfile(recentelecDir, '*.txt'), 'Choose .txt file of RAS coordinates');
    if ~elec_fn
        return;
    end
    recentelecDir = fpath;
    elec_fn = fullfile(fpath, elec_fn);
else
    elec_fn = elec_filename;
end
fprintf('Loading: %s\n', elec_fn);

elec_data = parse_RAS_file(elec_fn);

unames = unique(elec_data{1});

color = zeros(numel(elec_data{1}), 3);

if size(cfg.colors,1) > 1 % enable for distinct colors
    for u = 1:numel(elec_data{1})
        idx = find(strcmp(unames, elec_data{1}{u}), 1, 'first');
        color(u,:) = cfg.colors(idx,:);
    end
end

handle_scatter = scatter3(elec_data{3}, elec_data{4}, elec_data{5}, cfg.elec_size, color, 'filled');

if flag_show_labels % enable for label text
    for u = 1:numel(unames)
        idx = find(strcmp(elec_data{1}, unames{u}));
        f = idx(1); % first
        l = idx(end); % last
        text(elec_data{3}(f), elec_data{4}(f), elec_data{5}(f), unames{u}, 'fontsize', 16, 'color', [1 1 1]);
        for x = 2:2:(numel(idx)-1)
            text(elec_data{3}(idx(x)), elec_data{4}(idx(x)), elec_data{5}(idx(x)), ...
                num2str(elec_data{2}(idx(x))), 'fontsize', cfg.font_size, 'color', cfg.font_color);
        end
    end
end

end