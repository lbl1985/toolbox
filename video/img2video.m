function img2video(sourceFolder, savingFolder, savingName)

cd(sourceFolder);
% tmpSavingName = [filename '_' camId{j} '.mp4'];
comm2 = ['!ffmpeg -qscale 1 -r 20 -b 9600 -i img%4d.jpg ' ...
    fullfile(savingFolder, savingName)];
eval(comm2);
    