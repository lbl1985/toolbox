if ismac
    workingpath = '/Users/herbert19lee/Documents/MATLAB/work/dense';
elseif ispc    
    workingpath = 'C:\Users\lbl1985\Documents\MATLAB\work\dense';
elseif isunix
    workingpath = '/home/binlongli/workspace/dense';
    if ~exist(workingpath, 'dir')
        workingpath = '/home/binlong/workspace/dense';
    end
end  

% addpath(fullfile(workingpath, '90support'));
% dense_startup

cd(workingpath);
addpath(genpath(workingpath));