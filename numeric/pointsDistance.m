function dis = pointsDistance(p0, p1)
% Input: 
% p0:  n x m matrix, n is number of entries, m is dimensionality
% p1:  the same dimension as p0
% Output:
% dis: n x 1 matrix. (For euclidean distance only)
% Typical usage will be: p0 and p1 as groups of corresponding points
% We need to computer the moving distance between each point in p0 and p1

if size(p0) ~= size(p1)
    error('p0 has to be the same size as p1');
end

dis = sqrt(sum((p0 - p1).^2, 2));