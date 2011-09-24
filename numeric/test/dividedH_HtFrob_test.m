% function dividedH_HtFrob_test
A = (1 : 10)';
n = length(A);
m = 3;

AHankel = [hankel(A(1:m), A(m : n/2)); hankel(A(n/2+1 : n/2+m), A(n/2+m : n))];
AHankelSquare = AHankel * AHankel';
AHankelSquareFrob = norm(AHankelSquare, 'fro');

normFrob = dividedH_HtFrob(A, m);