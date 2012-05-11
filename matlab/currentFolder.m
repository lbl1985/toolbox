function path = currentFolder(p)
% input: 
%   p: output of mfilename('fullpath') from the call script.
% return the full path, where calling function stays.

if ispc
    index = strfind(p, '\');
else
    index = strfind(p, '/');
end
path = p(1:index(end)-1);