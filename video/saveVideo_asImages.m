function saveVideo_asImages(srcfile, destFolder, namepattern, ext)
% Example: 
% saveVideo_asImages('/Volumes/Security/sourceVideo/CLE_Data_20120830/camera_10_23.mp4', ...
% '/Users/herbert19lee/Desktop/camera', 'img_', '.jpg');
camera = cv.VideoCapture(srcfile);
checkFolder(destFolder);

nFrame = camera.get('FrameCount');
ndig = ceil(log(nFrame) / log(10));
for i= 1 : nFrame
    frame = read(camera);
    if ~isempty(frame)
        imwrite(frame, fullfile(destFolder, [namepattern num2str2(i, ndig) ext]));
    else
        i = i - 1; 
    end
end
    