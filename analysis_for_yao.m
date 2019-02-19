% Dependent Variables

    Y.rt = [];
    for it = 1:8
        Y.rt = [Y.rt; DATA.blockwise.rt.stan(1:length(filenames),it)];
        Y.rt = [Y.rt; DATA.blockwise.rt.nov(1:length(filenames),it)];
    end

    Y.errors = [];
    for it = 1:8
        Y.errors = [Y.errors; DATA.blockwise.rate.error.stan(1:length(filenames),it)];
        Y.errors = [Y.errors; DATA.blockwise.rate.error.nov(1:length(filenames),it)];
    end

    Y.miss = [];
    for it = 1:8
        Y.miss = [Y.miss; DATA.blockwise.rate.miss.stan(1:length(filenames),it)];
        Y.miss = [Y.miss; DATA.blockwise.rate.miss.nov(1:length(filenames),it)];
    end

    Y.failstop = [];
    for it = 1:8
        Y.failstop = [Y.failstop; DATA.blockwise.rate.failstop.stan(1:length(filenames),it)];
        Y.failstop = [Y.failstop; DATA.blockwise.rate.failstop.nov(1:length(filenames),it)];
    end
    
    Y.succstop = [];
    for it = 1:8
        Y.succstop = [Y.succstop; DATA.blockwise.rate.succstop.stan(1:length(filenames),it)];
        Y.succstop = [Y.succstop; DATA.blockwise.rate.succstop.nov(1:length(filenames),it)];
    end
    
% Preliminary setup

    %subject number
    S = [];
    sn = 1;
    for it = 1:size(Y.succstop,1)
              
        S = [S; sn];
        sn = sn + 1;
        if sn > length(filenames)
            sn = 1;
        end
        
    end
    
    % Modality code
    F1 = [];
    for it = 1:size(DATA.blockwise.rate.succstop.stan,2)
        
        a = zeros(length(filenames),1);
        a(:,1) = 1;
        b = zeros(length(filenames),1);
        b(:,1) = 2;
        F1 = [F1;a;b];
        
    end
    
    
    %block code (1:8)
    F2 = [];
    for it = 1:8
        block = zeros(length(filenames)*2,1);
        block(:,1) = it;
        F2 = [F2; block];
    end

    FACTNAMES = {'Modality', 'Block'};

% Plug and play

stats_rt = rm_anova2(Y.rt,S,F1,F2,FACTNAMES);
stats_error = rm_anova2(Y.errors,S,F1,F2,FACTNAMES);
stats_miss = rm_anova2(Y.miss,S,F1,F2,FACTNAMES);
stats_failstop = rm_anova2(Y.failstop,S,F1,F2,FACTNAMES);
stats_succstop = rm_anova2(Y.succstop,S,F1,F2,FACTNAMES);