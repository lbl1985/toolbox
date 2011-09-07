function arrayData = assembleCellData2Array(cellData, dim)
% This function is not done developing.
nCell = length(cellData);
siz = size(cellData{1});
finalSiz = calFinalSize(cellData{1}, dim, nCell);
arrayData = zeros(finalSiz);
for i = 1 : nCell
    switch num2str(dim)
        case '4'
            arrayData(:, :, :, i) = cellData{i};
        case '2'
            idx = (i-1) * siz(dim) + 1 : i * siz(dim);
            arrayData(:, idx) = cellData{i};
    end
    
    writenum(i);
    if mod(i, 20) == 0
        fprintf('\n');
    end
end
end

function outputSiz = calFinalSize(inputCell, dim, nCell)
outputSiz = size(inputCell);
if dim < ndims(inputCell)    
    outputSiz(dim) = outputSiz(dim) * nCell;
else
    outputSiz = [outputSiz nCell];
end
end