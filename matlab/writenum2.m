function writenum2(number, perLine)

%simple function to write a number (e.g. iteration count) on the screen

fprintf(' ')
fprintf(num2str(number));

if ~exist('perLine', 'var')
    perLine = 10;
end

if mod(number, perLine) == 0
    fprintf('\n');
end

%fflush produces an error in matlab but needed in octave:
try; fflush(stdout); catch; end