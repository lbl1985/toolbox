function properties = getopt(properties,varargin)
%GETOPT - Process paired optional arguments as 'prop1',val1,'prop2',val2,...
%
% getopt(properties,varargin) returns a modified properties structure,
% given an initial properties structure, and a list of paired arguments.
% Each argumnet pair should be of the form property_name,val where
% property_name is the name of one of the field in properties, and val is
% the value to be assigned to that structure field.
%
% No validation of the values is performed.
%
% EXAMPLE:
% properties = struct('zoom',1.0,'aspect',1.0,'gamma',1.0,'file',[],'bg',[]);
% properties = getopt(properties,'aspect',0.76,'file','mydata.dat')
% would return:
% properties =
% zoom: 1
% aspect: 0.7600
% gamma: 1
% file: 'mydata.dat'
% bg: []
%
% Typical usage in a function:
% properties = getopt(properties,varargin{:})

% Process the properties (optional input arguments)

prop_names = fieldnames(properties);
TargetField = [];
for ii=1:length(varargin)
  arg = varargin{ii};
  if isempty(TargetField)
    if ~ischar(arg)
      error('Propery names must be character strings');
    end
    f = find(strcmp(prop_names, arg));
    if length(f) == 0
      error('%s ',['invalid property ''',arg,'''; must be one of:'],prop_names{:});
    end
    TargetField = arg;
  else
    properties.(TargetField) = arg;
    TargetField = '';
  end
end
if ~isempty(TargetField)
  error('Property names and values must be specified in pairs.');
end