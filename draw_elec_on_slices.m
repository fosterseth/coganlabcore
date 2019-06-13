function draw_elec_on_slices(subj)
cfg = [];
cfg.pauseOn = 0;
cfg.printFigs = 1;
switch subj
    case 'D4'
        cfg.cntrst = 0.6;
    case 'D8'
        cfg.cntrst = 0.5;
    case 'D9'
        cfg.cntrst = 0.6;
    case 'D12'
        cfg.cntrst = 0.8;
    case 'D13'
        cfg.cntrst = 0.5;
    case 'D14'
        cfg.cntrst = 0.5;
    case 'D15'
        cfg.cntrst = 0.5;
    case 'D16'
        cfg.cntrst = 0.5;
    case 'D17'
        cfg.cntrst = 0.8;
    case 'D18'
        cfg.cntrst = 0.5;
    case 'D19'
        cfg.cntrst = 0.5;
    case 'D20'
        cfg.cntrst = 0.5;
end


plotMgridOnSlices(subj, cfg);