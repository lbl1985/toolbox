function img2video(sourceFolder, savingFolder, savingName, phrase)

ndigital = img2video_rename(sourceFolder, phrase);
cd(sourceFolder);
% tmpSavingName = [filename '_' camId{j} '.mp4'];
% comm2 = ['!ffmpeg -qscale 1 -r 20 -b 9600 -i img%' num2str(ndigital) 'd.jpg ' ...
comm2 = ['!ffmpeg -qscale 1 -r 20 -b 9600 -i img%' num2str(ndigital) 'd.jpg ' ...
    fullfile(savingFolder, savingName)];
eval(comm2);
    