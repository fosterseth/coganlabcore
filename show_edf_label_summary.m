function counts = show_edf_label_summary(labels)

for i = 1:numel(labels)
    mask = isletter(labels{i});
    names{i,1} = labels{i}(mask);
end

unames = unique(names);
counts = unames;

for i = 1:numel(unames)
    counts{i,2} = sum(strcmp(names, unames{i}));
end
end