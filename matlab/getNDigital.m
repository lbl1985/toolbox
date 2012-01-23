function ndigital = getNDigital(n)
% Calculate how many digital is required to name the images. 

ndigital = floor(log(n)/log(10) + 1);