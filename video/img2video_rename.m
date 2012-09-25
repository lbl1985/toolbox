function ndigital = img2video_rename(sourceFolder, phrase)
% Supplementary function for img2video. 
% Checkout whether the files in the folder qualifies the requirements as
% img%4d.jpg. 
% phrase: 
%       case1: img_disContinue
%              img%nd.jpg. but the numbers are discontinue.
%       case2: num
%              0.jpg 10.jpg. without img. only numbers, without padding

[~, filenames, n] = rfdatabase(sourceFolder, [], '.jpg');
ndigital = getNDigital(n);
switch phrase
    case 'img_disContinue'
        for j = 1 : n
            sourceFile = fullfile(sourceFolder, filenames{j});
            targetFile = fullfile(sourceFolder, ['img' num2str2(j, ndigital) '.jpg']);
            comm = ['!mv ' sourceFile ' ' targetFile];
            eval(comm);
        end
    case 'num'
        for j = 0 : n -1
            sourceFile = fullfile(sourceFolder, [num2str(j) '.jpg']);
            targetFile = fullfile(sourceFolder, ['img' num2str2(j, ndigital) '.jpg']);
            comm = ['!mv ' sourceFile ' ' targetFile];
            eval(comm);
        end
    case 'num2'
        for j = 1 : n
            sourceFile = fullfile(sourceFolder, filenames{j});
            targetFile = fullfile(sourceFolder, ['img' num2str2(j, ndigital) '.jpg']);
            comm = ['!mv ' sourceFile ' ' targetFile];
            eval(comm);
        end
        
end