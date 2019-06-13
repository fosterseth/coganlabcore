function gca_copyfigure
f = gcf;

for a = 1:numel(f.Children)
    if strcmp(f.Children(a).Type, 'axes')
        f.Children(a).ButtonDownFcn = @button_pressed;
        for c = 1:numel(f.Children(a).Children)
            f.Children(a).Children(c).HitTest = 'off';
        end
    end
end

    function button_pressed(h,event)
        figure(h.Parent);
        cc = colormap();
        g = figure;
        copyobj(h, g);

        figure(g);
        colormap(cc);
        ax = gca;
        ax.Position = [.13 .11 .775 .815];
    end
end