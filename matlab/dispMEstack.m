function dispMEstack(stack)
n = length(stack);
disp(' ');
for i = 1 : n
    disp(['file: ' stack(i).file]);
    disp(['name: ' stack(i).name]);
    disp(['line: ' num2str(stack(i).line)]);
    disp(' ');
end