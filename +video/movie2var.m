function mat = movie2var(filename, isGray, siz)
% isGray could be [] or 0. The program will reserve the original format
if ~ispc
    currPath = pwd;
end
video = mmread(filename);
n = length(video.frames);
sampleFrame = video.frames(1).cdata;

if isempty(isGray)
    % user dont' specifically require for gray or rgb. Then save it as the
    % original format    
    if ndims(sampleFrame) > 3
        isGray = 0;
    else
        isGray = 1;
    end
end

dimensions = size(sampleFrame);
dimensions = dimensions(1:2);

if siz ~= 1    
    numrows = ceil(dimensions(1) * siz);
    numcols = ceil(dimensions(2) * siz);
else
    numrows = dimensions(1);
    numcols = dimensions(2);
end

if ~isGray
    mat = uint8(zeros(numrows, numcols ,3, n));    
    for i = 1 : n
        mat(:, :, :, i) = uint8(imresize(video.frames(i).cdata, [numrows numcols]));        
    end
else
    
    mat = uint8(zeros(numrows,numcols, n));
    for i = 1 : n
        mat(:, :, i) = uint8(imresize(rgb2gray(video.frames(i).cdata), [numrows numcols]));
    end
end

if ~ispc
    cd(currPath);
end