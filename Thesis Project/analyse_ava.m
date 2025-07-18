clear, close all

% path details
loadpath = '% enter load path here';

% list subject IDs
allsubj = {% enter 4 letter participant code here};

% list conditions
allcond = [1 2 3];
ntrials = 18;

% set up text import options
opts = delimitedTextImportOptions("NumVariables", 32);
opts.DataLines = [1, Inf];
%opts.Delimiter = [" ", ",", ";", "="];
opts.Delimiter = [",", ";", "="];
opts.VariableNames = ["ORDER",  "vName2", "vName3", "vName4", "vName5", "vName6", "vName7", "vName8", "vName9", "vName10", "vName11", "vName12", "vName13", "vName14", "vName15", "vName16", "vName17", "vName18", "vName19", "vName20", "vName21", "vName22", "vName23", "vName24", "vName25", "vName26", "vName27", "vName28", "vName29", "vName30", "vName31", "vName32"];
opts.VariableTypes = ["string", "string", "double", "double", "string", "string", "double", "double", "string", "string",  "double",  "double",  "string",  "string",  "double",  "double",  "string",  "string",  "double",  "double",  "string",  "string",  "double",  "double",  "string",  "string",  "double",  "double",  "string",  "string",  "double",  "double"];
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts = setvaropts(opts, ["ORDER", "vName2", "vName5", "vName6", "vName9", "vName10", "vName13", "vName14", "vName17", "vName18", "vName21", "vName22", "vName25", "vName26", "vName29", "vName30"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["ORDER", "vName2", "vName5", "vName6", "vName9", "vName10", "vName13", "vName14", "vName17", "vName18", "vName21", "vName22", "vName25", "vName26", "vName29", "vName30"], "EmptyFieldRule", "auto");

% Loop through files
dat = struct(); dat.subj=[]; dat.cond=[]; dat.tlen=[]; dat.letters={}; dat.recalled={}; dat.accM=[]; dat.accS=[];
perf = struct(); perf.n=[]; perf.acc=[]; perf.PU=[]; perf.PL=[]; perf.FU=[]; perf.FL=[];
for subj = 1:length(allsubj)
    for cond = 1:length(allcond)
        % import data
        opts.Delimiter = [",", ";", "="];
        dat_in = readtable([loadpath,allsubj{subj},'_condition',num2str(allcond(cond)),'.txt'], opts);
        
        dat.tlen(end+1,1) = str2double(dat_in{1,1}{1}(end));  % pull first trial length

        % pull single-trial data into sensible format
        for t = 1:ntrials
            % record particpants
            dat.subj(end+1,1) = subj;

            % record condition
            dat.cond(end+1,1) = allcond(cond);
            
            % record trial length
            if t~=1
                if ~isnumeric(dat_in{1,t})
                    dat.tlen(end+1,1) = str2double(dat_in{1,t});
                else dat.tlen(end+1,1) = dat_in{1,t};
                end
            end

            % loop through items within trial and record relevant info
            for i = 1:dat.tlen(end)
                i2 = 1 + 4*(i-1);
                dat.letters{length(dat.tlen),i} = dat_in{t+4,i2};
                dat.recalled{length(dat.tlen),i} = dat_in{t+4,i2+1};
                dat.accM(length(dat.tlen),i) = dat_in{t+4,i2+2};
                dat.accS(length(dat.tlen),i) = dat_in{t+4,i2+3};
                if dat.tlen(end)~=7  % fill non-element positions for this trial with NaNs
                    dat.accM(end,dat.tlen(end)+1:7) = nan;
                    dat.accS(end,dat.tlen(end)+1:7) = nan;
                end
            end
        end

        % pull trial lengpre-computed accuracies into sensible format
        opts.Delimiter = [" ", ",", ";", "="];  % reloading data in more readable format for pulling pre-computed accuracies
        dat_in = readtable([loadpath,allsubj{subj},'_condition',num2str(allcond(cond)),'.txt'], opts);
                             
        perf.n(subj,cond) = str2double(dat_in{end,2}{1});
        perf.acc(subj,cond) = str2double(dat_in{end,6}{1}(1:2));
        perf.PU(subj,cond) = str2double(dat_in{end,9}{1});
        perf.PL(subj,cond) = dat_in{end,12};
        perf.FU(subj,cond) = dat_in{end,15};
        perf.FL(subj,cond) = str2double(dat_in{end,18}{1});
    end
end

% plot pre-computed sentence accuracy across conditions
figure, hold on
plot(1:3,perf.acc)
xlabel('Condition'), ylabel('Accuracy (%)')
set(gca,'TickDir','out')

subplot(1,2,2), hold on
plot(1:3,perf.PU)
xlabel('Condition'), ylabel('PU score')
set(gca,'TickDir','out')

% plot correlation matrix of pre-computed WM scores
figure,
corrplot([perf.acc(:) perf.PU(:) perf.PL(:) perf.FU(:) perf.FL(:)])







