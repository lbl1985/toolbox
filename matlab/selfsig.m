function selfsig()
% Generate myself signature
% This could easily fixed for other people in order to generate their own
% signature
% Binlong Li    Friday   16-Nov-12  9:40AM
str = ['Binlong Li    ' datestr(clock, 'dddd') '   ' datestr(now, 'dd-mmm-yy HH:MMAM')];
display(str);