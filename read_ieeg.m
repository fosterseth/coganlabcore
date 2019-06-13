function data = read_ieeg(filename, num_channels, sample_begin, sample_end)
fprintf('%f %f\n', sample_begin, sample_end);
sample_begin = sample_begin - 1;
sample_end = sample_end - 1;

fid = fopen(filename, 'r');

fseek(fid, sample_begin * 4 * num_channels, 'bof'); % assume single
data = fread(fid, [num_channels, sample_end-sample_begin + 1], 'single=>double', 0);


fclose(fid);
end