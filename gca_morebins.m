function gca_morebins

f = gcf;
f.UserData.hist_handles = {};
for a = 1:numel(f.Children)
    ax = f.Children(a);
    
    for c = 1:numel(ax.Children)
        if strcmp(ax.Children(c).Type, 'histogram')
            f.UserData.hist_handles{end+1} = ax.Children(c);
        end
    end
end

register_KeyPressFcn(f, 'KeyPressFcn', @button_pressed);

function button_pressed(h,e)
    if e.Character == '='
        morebins(h.UserData.hist_handles{1});
        for n = 2:numel(f.UserData.hist_handles)
            match_bins(f.UserData.hist_handles{n}, f.UserData.hist_handles{1});
        end
    elseif e.Character == '-'
        fewerbins(h.UserData.hist_handles{1});
        for n = 2:numel(f.UserData.hist_handles)
            match_bins(f.UserData.hist_handles{n}, f.UserData.hist_handles{1});
        end
    end
end
end

function match_bins(handle1, handle2)
handle1.NumBins = handle2.NumBins;
handle1.BinEdges = handle2.BinEdges;
handle1.BinWidth = handle2.BinWidth;
handle1.BinLimits = handle2.BinLimits;
end