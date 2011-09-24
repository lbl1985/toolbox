% function dividedH_HtFrob_test
clear;
% A = (1 : 10)';
A = rand(30, 1);
n = length(A);
m = 5;

AHankel = [hankel(A(1:m), A(m : n/2)); hankel(A(n/2+1 : n/2+m), A(n/2+m : n))];
AHankelSquare = AHankel * AHankel';
AHankelSquareFrob = norm(AHankelSquare, 'fro');

normFrob = dividedH_HtFrob(A, m);
c = comparedata(AHankelSquareFrob, normFrob);
assert(isequal(c, 1), 'dividedH_HtFrob is broken.');