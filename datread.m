function [hdr, data] = datread(filename, channels)
fid = fopen(filename, 'r');
header_length = fread(fid, 1, 'int16=>int16');
jsonraw = fread(fid, header_length, 'char=>char');
hdr = jsondecode(jsonraw);


if nargin < 2 || isempty(channels)
    channels = 1:length(hdr.labels);
end

if isa(channels, 'double')
    channels = num2cell(channels);
end

if nargout > 1
    data = cell(1,hdr.nchannels);

    if ~iscell(channels)
        channels = {channels};
    end
    
    new_channels = [];
    for c = 1:numel(channels)
        if ischar(channels{c}) % if character, convert to number
            for x = 1:numel(hdr.label)
                if strcmp(channels{c}, hdr.label{x})
                    new_channels = cat(1,new_channels,x);
                end
            end
        else % if number, just keep it
            if channels{c} > 0 && channels{c} <= numel(hdr.labels)
                new_channels = cat(1,new_channels,channels{c});
            end
        end
    end
    
    channels = sort(new_channels);
    
    for t = 1:hdr.nchannels
        if ismember(t,channels)
            data{t} = fread(fid, [1 hdr.nsamples], 'int16') * hdr.scalefac + hdr.dc;
        else
            fseek(fid, hdr.nsamples*2, 0);
        end
    end
    
    data = vertcat(data{:});
end
fclose(fid);
end