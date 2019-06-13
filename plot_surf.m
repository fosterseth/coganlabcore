function handle_surf = plot_surf(surf_filename, cfg)
% PLOT_SURF    plots .pial or .mat surface data
%     handles = plot_surf(surf_filename, cfg);
%     All arguments are optional
%     Type "help plot_defaults" to see cfg parameters


%% Load Defaults like electrode size, font color, etc.
if nargin < 1
    surf_filename = '';
end

if nargin < 2
    cfg = [];
end

cfg = plot_defaults(cfg);



%% Load .pial data

cort = load_pial_data(surf_filename);


%% Plot the surface and adjust lighting
surf_color = repmat(cfg.surf_color, size(cort.vert,1), 1);

f = figure;
handle_surf=trisurf(cort.tri, cort.vert(:, 1), cort.vert(:, 2), cort.vert(:, 3), 'FaceVertexCData', surf_color);
set(f, 'color', cfg.background_color);

axis tight; axis equal;
shading interp;
lighting gouraud; material dull;
alpha(cfg.alpha);

hide_axis(gca);

camlight_follow(gca);

hold on;

end