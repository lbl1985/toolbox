function outputChar = charArray2char(inputChar)
% Convert a r x c char array to 1 x n long char
% This is invoked by the different 'ls' results from Unix and Windows
% system.
if isempty(inputChar)
    outputChar = [];
else
    outputChar = deblank(inputChar(1, 1 : end));
    nrow = size(inputChar, 1);
    for i = 2 : nrow
        outputChar = sprintf('%s\t%s', outputChar, deblank(inputChar(i, 1 : end)));
    end
end