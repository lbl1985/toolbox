function isExist = checkFolder(dest)
% Check whether the dest folder is exist. 
% If yes, returen isExist = true.
% els, return isExist = false. Meanwhile, create the dest folder 
if exist(dest, 'dir')
    isExist = true;
else
    isExist = false;
    mkdir(dest);
end