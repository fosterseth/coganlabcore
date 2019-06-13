function idx = find_sequence_of_values(data, value, num_in_row)

idx = 0;
count = 0;

if num_in_row == 0
    idx = find(data == value);
    return;
end

for i = length(data):-1:1
    if data(i) == value
        idx(end) = i;
        count = count + 1;
    else
        if count < num_in_row
            idx(end) = 0;
        else
            idx = cat(1,idx,0);
        end
        count = 0;
    end
end

if count < num_in_row
    idx = idx(1:end-1);
end

idx = idx(end:-1:1);

end