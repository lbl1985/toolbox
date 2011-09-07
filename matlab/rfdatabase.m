function [srcdir filenames n] = rfdatabase(srcdir, prefix, ext)
% Named after: read-from-database
% This function is just for my connivent to read data from database,
% nontrial speaking the database is always arranged by prefix_*.mat and
% focus putting in one folder. Then I hope this funtion can help us a lot
% give us some convient. 
% INPUT:
% srcdir:       the main source dir where database located.
% prefix:       prefix which we interested on
% OUTPUT:
% srcdir:       after judge whether we need to add a '/' or '\' behand the srcdir
%               input, we need to output the srcdir.
% fielnames:    The files with prefix in our database folder.
% n:            number of files with specified prefix in the folder
% EXAMPLE:
% [srcdir filenames n] = rfdatabase(datadir(0), 'clip');
% Binlong's MATLAB Toolbox version 1.00
% TIMESTAMP:    10:00PM     05/OCT/2009

    if (~isempty(srcdir))
        if(~exist(srcdir, 'dir')) error( ['feval_frame: dir ' srcdir ' not found' ]); end
        if(srcdir(end)~='\' && srcdir(end) ~= '/') srcdir(end + 1) = '/'; end;
    end
    
    %%% get appropriate filenames
    if nargin == 2
        if( isempty(prefix) ) 
            dircontent = dir( [srcdir '*.mat'] ); 
        else
            dircontent = dir( [srcdir prefix '*.mat'] ); 
        end
    elseif nargin == 3
        if ~strcmp(ext, 'dir')
            % if targets are files instead of folders
            if( isempty(prefix) ) 
                dircontent = dir( [srcdir '*' ext] ); 
            else
                dircontent = dir( [srcdir prefix '*' ext] ); 
            end
        else
            % If targets are folders, only need the folders name, not '.'
            % and '..'
            dircontent = dir(srcdir);
            dircontent = dircontent(3:end);
        end
    end
    
    filenames = {dircontent.name}; n = length(dircontent);        
    if( n==0 ) error( ['No appropriate mat files found in ' srcdir] ); end;