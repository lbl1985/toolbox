function outVar = readTxt2Var(filename)
fid = fopen(filename);
if fid < 0
    error([filename ' can not be opened']);
end

tline = fgetl(fid);
outVar = [];

while tline ~= -1 
%     display(tline);
    outVar = cat(1, outVar, str2num(tline));    
    tline = fgetl(fid);
end

fclose(fid);