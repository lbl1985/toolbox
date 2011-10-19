function symMatrix = dividedH_Ht(A, hankelWindowSize)
n = size(A, 1);
m = hankelWindowSize;
[rowId1 rowId2 w] = generateRowId(n, m);
B = bsxfun(@times, A(rowId1, :), A(rowId2, :));
% B = A(rowId1, :) .* A(rowId2, :);
symMatrix = w * B;



end

function [row1 row2 w] = generateRowId(n, m)
p = n/2 - m + 1;
row1 = (1:n)';
row2 = (1:n)';
if m == p
    w = spdiagsCat(spdiags(ones(p, m), (0:p-1), m, n/2), spdiags(ones(p, m), (0:p-1), m, n/2));
else    
    w = getTmpW(n/2, p);
    tmpW= getTmpW(n/2, p);
    w = spdiagsCat(w, tmpW);
end
    
rowStart = [1 2];
endStart = [1 n - p + 1];
dis = 1;
while ~isequal(rowStart, endStart)
    [indLen newStart dis] = getIndexLength(n, m, rowStart, dis);
    tmpRow1 = (rowStart(1) : rowStart(1) + indLen - 1)';
    tmpRow2 = (rowStart(2) : rowStart(2) + indLen - 1)';
    row1 = cat(1, row1, tmpRow1);
    row2 = cat(1, row2, tmpRow2);
    if indLen == p
        tmpW = ones(1, p);
    else
        tmpW = getTmpW(indLen, p);     
    end
    w = spdiagsCat(w, tmpW);
    rowStart = newStart;
end
tmpRow1 = (rowStart(1) : rowStart(1) + p - 1)';
tmpRow2 = (rowStart(2) : rowStart(2) + p - 1)';
row1 = cat(1, row1, tmpRow1);
row2 = cat(1, row2, tmpRow2);
w = spdiagsCat(w, ones(1, p));
end

function [indLen newStart dis] = getIndexLength(n, m, rowStart, dis)
    p = n/2 - m + 1;
    flagIndex = n/2;
    compareStatus = rowStart < flagIndex;
    assert(~isequal(compareStatus, [0 1]), ['rowStart: ' num2str(rowStart) ' must be wrong.']);
    if isequal(compareStatus, [1 1])
        tmpRow1 = (rowStart(1) : n/2)';
        tmpRow2 = (rowStart(2) : n/2)';
        [indLen status] = min([length(tmpRow1) length(tmpRow2)]);        
        newStart(status) = flagIndex + 1;
        otherRow = floor((status + 1)/status);
        newStart(otherRow) = rowStart(otherRow) + indLen - p + 1;    
    elseif isequal(compareStatus, [1 0])
        tmpRow1 = (rowStart(1) : n/2)';
        tmpRow2 = (rowStart(2) : n)';
        if length(tmpRow1) == length(tmpRow2)
            indLen = length(tmpRow2);            
            dis = dis + 1;
%             dis = getDis(dis, n, p, m);
            newStart(1) = 1;
            newStart = getNewStart2(dis, m, newStart, flagIndex);
        else            
            [indLen status] = min([length(tmpRow1) length(tmpRow2)]);
            if status == 1
                newStart(status) = flagIndex + 1;
                newStart(2) = rowStart(2) + indLen - p + 1;
            else
                dis = dis + 1;
%                 dis = getDis(dis, n, p, m);
                newStart(1) = 1;
                newStart = getNewStart2(dis, m, newStart, flagIndex);
            end
        end
    elseif isequal(compareStatus, [0 0])
        tmpRow1 = (rowStart(1) : n)';
        tmpRow2 = (rowStart(2) : n)';
        % this must be status == 2
        [indLen status] = min([length(tmpRow1) length(tmpRow2)]);
        assert(status == 2, ['rowStart: ' num2str(rowStart) ' must be wrong.']);
        dis = dis + 1;
%         dis = getDis(dis, n, p, m);
        newStart(1) = 1;
        newStart = getNewStart2(dis, m, newStart, flagIndex);
    end        
end

function dis = getDis(dis, n, p, m)
    tmpdis = dis + 1;
    if 1 + tmpdis + p - 1 == n/2 + 1
        dis = m;
    else
        dis = tmpdis;
    end
end
function newStart = getNewStart2(dis, m, newStart, flagIndex)
    if dis < m
        newStart(2) = newStart(1) + dis;
    else
        newStart(2) = flagIndex + 1 + ( dis - m);
    end
end

function tmpW = getTmpW(indLen, p)
    numRep = indLen - p + 1;
    tmpW = zeros(numRep, p + numRep - 1);
    for i = 1 : numRep
        tmpW(i, i : p + i -1) = ones(1, p);
    end
end