function nstr = num2str2(num, ndigital)
% Similiar functionality with int2str2. 
% Here, we borrow the functionality from built in function sprintf.
% Binlong Li    26 Nov 2011 Sat
% Binlong Li's Toolbox
comm = ['nstr = sprintf(''%0' num2str(ndigital) 'd'', num);'];
eval(comm);

