function readcvml(xmlfile, savingFolder)
filename = xmlfile(1:end-4);
tgtFile = [filename '.csv'];  
comm = ['!xsltproc /Users/herbert19lee/Documents/MATLAB/toolbox/cvml/cvml_csv.xslt ' xmlfile '> ' fullfile(savingFolder, tgtFile)];
eval(comm);
comm = [filename ' = dlmread(''' tgtFile ''');'];
eval(comm);
save(fullfile(savingFolder, [filename '.mat']), filename);
comm = ['!rm ' fullfile(savingFolder, tgtFile)];
eval(comm);