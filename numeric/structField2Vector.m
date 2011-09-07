% Capture the filed of a stack of structure into a single matrix. Then we
% can do the matrix operation on that output matrix, to obtain the idx we
% need for certain purpose.(Location for max or min value of that field.)
%
% Input: 
% s:            Structure Stack. A stack of struct with the same struct 
%               fields.
% FieldName:    Field name, we want to extract from s.
%
% Output:
% vector:       matrix with field values extracted from Structrue Stack s.
%
% Example:
% vector = structField2Vector(s, 'NumObjects');
% 
% See also: 
% 
function vector = structField2Vector(s, FieldName, varargin)

% k = eval(['length(s(1).' FieldName ')']);
if isempty(varargin)
    mode = 'scalor';
else
    mode = varargin{1};
end

if nargin > 3
    mode2 = varargin{2};
else
    mode2 = '';
end
    
switch mode
    case 'scalor'
        if iscell(s)
            vector = zeros(length(s), eval(['length(s{1}.' FieldName ')']));
        else
            vector = zeros(length(s), eval(['length(s(1).' FieldName ')']));
        end
        
        for i = 1 : length(s)
            if iscell(s)
                vector(i, :) = eval(['s{' num2str(i) '}.' FieldName ';']);
            else
                vector(i, :) = eval(['s(' num2str(i) ').' FieldName ';']);
            end
        end
    case 'Matrix'
        vectorMatrix = cell(length(s), 1);
        for i = 1 : length(s)
            if iscell(s)
               vectorMatrix{i} = eval(['s{' num2str(i) '}.' FieldName ';']);
            else
                vectorMatrix{i} = eval(['s(' num2str(i) ').' FieldName ';']);
            end
        end
        switch mode2
            case 'heigthOfRegion'
                vector = zeros(length(s), 1);
                for i = 1 : length(s)
                    vector(i) = abs(vectorMatrix{i}(6, 2) - vectorMatrix{i}(1, 2)) + 1;
                end
%             case 'CentroidOfAllRegions'
%                 vector = zeros(length(s), 2);
%                 for i = 1 : length(s)
%                     vector(i, :) = vectorMatrix{i};
%                 end
%                 vect
            case 'cellDatabase'
                % We only need the last entry of vectorMatrix{i} from
                % before.
                % Example (in databaseFuncCell.m): 
                % centroidsBefore = structField2Vector(DB, 'Centroid', 'Matrix', 'cellDatabase');
                vector = zeros(length(s), size(vectorMatrix{1}, 2));
                for i = 1 : length(s)
                    vector(i, :) = vectorMatrix{i}(end, :);
                end
            otherwise
                vector = vectorMatrix;
        end                
end
