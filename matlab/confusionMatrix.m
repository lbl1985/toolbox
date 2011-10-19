function [M per] = confusionMatrix(Result, varargin)

if isempty(varargin)
    mode = 'default';
else
    mode = 'multi';
    groundTruth = varargin{1};
end

switch mode
    case 'default'

        ntypes = length(Result);
        M = zeros(ntypes);
        for i = 1 : ntypes
            for j = 1 : ntypes
                M(i, j) = length(find(Result{i}(:, 1) == (j - 1)));
            end
        end
        per = sum(diag(M)) / sum(M(:));
    case 'multi'
        numbers = unique(groundTruth);
        nNumbers = length(numbers);
        M = zeros(nNumbers);
        
        for i = 1 : length(numbers)
            ind = find(groundTruth == numbers(i));
            for j = 1 : length(numbers)
                M(i, j) = length(find(Result(ind) == numbers(j)));
            end
        end
        per = sum(diag(M)) / length(groundTruth);
%         per = sum(diag(M)) / sum(M(:));
end
            
        