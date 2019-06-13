function vox2ras(sub)% https://surfer.nmr.mgh.harvard.edu/fswiki/CoordinateSystems
global RECONDIR;

map_to = [];

fid = fopen(fullfile(RECONDIR, sub, 'elec_recon', [sub 'PostimpLoc.txt']), 'r');
elec_all = textscan(fid,'%s %d %f %f %f %s %s');
fclose(fid);

if ~isempty(map_to)
    elec_all{2}(1:length(map_to)) = map_to;
end

vox = cat(2, elec_all{3:5});
v2r = [-1 0 0 128; 0 0 -1 128; 0 -1 0 128; 0 0 0 1];
ras = (v2r *[vox';ones(1,size(vox,1))])';

fn = fullfile(RECONDIR, sub, 'elec_recon', [sub '_elec_locations_RAS.txt']);
fid = fopen(fn, 'w');
for e = 1:size(ras,1)
    towrite = sprintf('%s %d %f %f %f %s %s\n', elec_all{1}{e}, elec_all{2}(e), ras(e,1), ras(e,2), ras(e,3), elec_all{6}{e}, elec_all{7}{e});
    fwrite(fid, towrite);
end
fclose(fid);

fprintf('saved: %s\n',  fn);

end