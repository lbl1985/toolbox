function projectBaseFolder = getProjectBaseFolder
projectBaseFolder = which('denseFlag.m');
projectBaseFolder = projectBaseFolder(1:strfind(projectBaseFolder, 'denseFlag.m') - 1);
 