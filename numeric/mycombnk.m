function m=mycombnk(n,k)
% MYCOMBNK returns combinatorial of n choose k
% i.e all unique combinations of n elements 
% taken k at a time.
%
% EX: >> mycombnk(6,2)
% ans = 15
%

% check args
if nargin < 2, error('Too few input parameters'); end

% check for scalar input
s = isscalar(k) & isscalar(n);
if (~s), error('Non-scalar input'); end

% check for invalid input parameter
ck = k > n;
if (ck), error('Invalid input'); end

% check for zero or positive input
z = k >= 0 & n > 0;
if (~z), error('Negative or zero input'); end

m = factorial(n)/(factorial(k)*factorial(n-k));

end