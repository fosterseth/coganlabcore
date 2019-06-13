function struct_array = cells2structs(cells_of_structs)
for c = 1:numel(cells_of_structs)
    struct_array(c) = cells_of_structs{c};
end
end