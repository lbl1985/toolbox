function dis = pairwiseDistance(f, t)
% Input: 
% f:  features matrix, k x 2 matrix
% t:  tracks ending p, n x 2 matrix
% compute distance between k points in f to n points in t. Generate
% similarity matrix with dimensionality k x n
% 
% each row represents the distance between 1 point in f to all points in t
% 
% 
% first = (fx^2 + fy^2) * (tx^2 + ty^2)';
first = bsxfun(@plus, dot(f, f, 2), dot(t, t, 2)'); 

second = f * t';

dis = first - 2 * second;

dis = sqrt(dis);
