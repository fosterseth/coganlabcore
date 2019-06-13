function freesurfer_makeIniLocTxtFile(subj, minimizechange)

if nargin < 2
    minimizechange = 1;
end

global RECONDIR;
global globalFsDir;
oRECONDIR = RECONDIR;
RECONDIR = globalFsDir;

% makeIniLocTxtFile(subj);
dykstraElecPjct(subj, minimizechange);

RECONDIR = oRECONDIR;
end