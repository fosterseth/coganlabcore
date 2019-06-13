function [data, h] = get_dat_channels(subject, channels)
% returns channels x datapoints array

if nargin < 2
    channels = [];
end
[h,data] = datread(fullfile(get_subject_path(subject), sprintf('s%d.dat', subject)), channels);
    