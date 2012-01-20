function outVideo = videoHistEqual(inVideo)

outVideo = inVideo;
nFrames = size(inVideo, 3);
for i = 1 : nFrames
%     outVideo(:, :, i) = histeq(inVideo(:, :, i));
    outVideo(:, :, i) = inVideo(:, :, i) >= 255 * graythresh(inVideo(:, :, i));    
end
outVideo = 255 * outVideo;