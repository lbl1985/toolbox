batchFeature = ones(10, 1) * (1 : 10);
for i = 1 : 3
    indice{i}.start = (i - 1) * 4 + 1; 
    indice{i}.end = (i - 1) * 4 + 2;
end

out = separateBatch(batchFeature, indice);
answer = ones(10, 1) * [1 2 5 6 9 10];

assert(isequal(out, answer), 'separateBatch is borken');