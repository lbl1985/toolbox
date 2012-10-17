function readcvml(xmlfile, savingFolder)
% Read .xml file, which is written in CVML format, then convert and saved
% as .mat file.
% Input: 
% xmlfile:      .xml file name. It could include the absolute path or only the
%               file name lies in the current folder
% savingFolder: where the .mat file will be saved. 
% Output: 
% .mat file     live in savingFolder. 
% 
% Author:       Binlong Li      16 Oct 2012     21:45
ind = strfind(xmlfile, '/');
if ~isempty(ind)
    filename = xmlfile(ind(end)+1:end-4);
else
    filename = xmlfile(1:end-4);
end

tgtFile = [filename '.csv'];  
comm = ['!xsltproc /Users/herbert19lee/Documents/MATLAB/toolbox/cvml/cvml_csv.xslt ' xmlfile '> ' fullfile(savingFolder, tgtFile)];
eval(comm);
comm = [filename ' = dlmread(''' tgtFile ''');'];
eval(comm);
save(fullfile(savingFolder, [filename '.mat']), filename);
comm = ['!rm ' fullfile(savingFolder, tgtFile)];
eval(comm);