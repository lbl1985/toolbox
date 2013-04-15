function test_label(isLoad, isLoadCur, begin)
saveFolder = fullfile('./extract_11');
[srcdir filenames n] = rfdatabase(saveFolder, [], '.jpg');

% frameAnt = [];
if isLoad
    load('AllframeAnt.mat');    
else
    if begin ~= 1
        frameAnt = cell(begin-1, 1);
    else
        frameAnt = [];
    end
end

nType = 3;
color = varycolor(nType);
for i = length(frameAnt)+1 : n
    if isLoadCur
        load(['frame' num2str2(1, 5) 'ant.mat']);
    else
        curFrame = cell(nType, 1);  % each cell contains one type
    end
    isContinue = 1;
    imshow(fullfile(saveFolder, filenames{i}));
    
    title(['Frame ' num2str(i)]);
    if i ~= 1
        if ~isempty(frameAnt{i-1})
            for j = 1 : nType
                tmp = frameAnt{i-1}{j};
                if ~isempty(tmp)
                    for k = 1 : length(tmp)
                        tmpPos = tmp(k).pos;
                        hp = impoly(gca, tmpPos);
                        setColor(hp, color(j, :));
                        [isKept isRemove] = promptIsKept();
                        if isKept
                            obj.pos = tmpPos;
                            obj.BW = createMask(hp);
                            curFrame{j} = cat(1, curFrame{j}, obj);
                        else
                            if ~isRemove
                                obj.pos = wait(hp);
                                obj.BW = createMask(hp);
                                curFrame{j} = cat(1, curFrame{j}, obj);
                            else
                                delete(hp);
                            end
                        end                        
                    end
                end
            end
        end
    end
    
    isContinue = promptIsContinue;
    if ~isContinue
        save(['CurFrame' filenames{i}(5:9) 'ant.mat'], 'curFrame');
    end
    
    while isContinue
        answer = promptBeginLabel;
        hp = impoly();
        setColor(hp, color(answer, :));
        obj.pos = wait(hp);
        obj.BW = createMask(hp);
        curFrame{answer} = cat(1, curFrame{answer}, obj);
        [isContinue isSave]= promptIsContinue();
        if isSave            
            save(['CurFrame' filenames{i}(5:9)  'ant.mat'], 'curFrame');
        end
    end
    frameAnt = cat(1, frameAnt, {curFrame});
    save AllframeAnt frameAnt;
end
end 

function type = promptBeginLabel
prompt = {'Type: Car-1 People-2 Bike-3'};
dlg_title = 'Input label info';
num_lines = 1;
def = {'1'};
answer = inputdlg(prompt, dlg_title, num_lines, def);
type = str2double(answer{1});
end

function [isContinue isSave] = promptIsContinue
prompt = {'Label next one? Yes-1 No-0', 'Is save'};
dlg_title = 'Is Continue & Save';
num_lines = 2;
def = {'1', '1'};
answer = inputdlg(prompt, dlg_title, num_lines, def);
isContinue = str2double(answer{1});
isSave      = str2double(answer{2});
end

function [isKept isRemove] = promptIsKept
prompt = {'Is this region the same?', 'Is this region removed No-0 Yes-1'};
dlg_title = 'Is kept';
num_lines = 2;
def = {'1', '0'};
answer = inputdlg(prompt, dlg_title, num_lines, def);
isKept = str2double(answer{1});
isRemove = str2double(answer{2});

end




% clear; close all; clc;
% figure, imshow('gantrycrane.png');
% 
% hp = impoly();
% pos1 = wait(hp);
% 
% hp2 = impoly(gca, pos1);
% pos2 = wait(hp2);