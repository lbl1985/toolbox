function varargout =  varin2out(varargin)
% only for batch output the varargin into several variables.
% Binlong Li    25 June 2011    08:08AM
% Input to this function can only but one variable
% Binlong Li    29 June 2011    05:14PM
if length(varargin) ~= 1
    error('Input to this function can only be ONE variable');
end
varargin = varargin{1};
n = length(varargin);
for i = 1 : n
    temp = varargin{i};
    if iscell(temp) && length(temp) == 1
        varargout{i} = temp{1};
    else
        varargout{i} = temp;
    end
end