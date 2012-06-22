function growl(message)
% Using growl to notify maltab running finished
% Example:
% growl('finished test'), where test will be the title, finish will be
% content
% Binlong Li        22 June 2012 

cmd = ['/usr/local/bin/growlnotify -I /Applications/MATLAB_R2010b.app -m' ...
    message];
system(cmd);

end