function gca_clear(plottype)
ax = gca;

if nargin < 1
    x = {};
    for a = 1:numel(ax.Children)
        x = cat(1, x, ax.Children(a).Type);
    end
    x = unique(x);
    disp(x);
    return;
end

to_remove = [];
for a = 1:numel(ax.Children)
    if strcmp(ax.Children(a).Type, plottype)
        to_remove = cat(1, to_remove, ax.Children(a));
    end
end
delete(to_remove);
end