function [status, result] = git(varargin)

if ispc
    cmd = '"c:\Program Files (x86)\Git\cmd\git.cmd"';
end
if ismac
    cmd = '"/usr/local/git/bin/git"';
end
if isunix
    cmd = '"/usr/bin/git"';
end
        
for i = 1:numel(varargin)
    cmd = [cmd ' ' varargin{i}];
end
switch nargout
    case 0, system(cmd);
    case 1, [status] = system(cmd);
    case 2, [status, result] = system(cmd);
end