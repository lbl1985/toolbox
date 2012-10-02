function d = point_to_line(pt, LINES)
% According to webpage: 
% http://mathworld.wolfram.com/Point-LineDistance2-Dimensional.html
% equation (11)
% Input: 
% pt:       n x 2 matrix, [colnum rows] ([x y] in painting)
% LINES:    m x 3 matrix, [A B C] for line equations
% Output: 
% d:        n x m matrix, distance of every point to each lines
% Related to:   HankeletComp.m  epipolarLine.m
%
% According to webpage: 
% http://www.mathworks.com/support/solutions/en/data/1-1BYSR/index.html?product=ML&solution=1-1BYSR
% http://www.mathworks.com/matlabcentral/newsreader/view_thread/164048
% v1, v2 is the vetex of the a line segment
% pt is the querying point
% This function will return the distance between point pt to the line
% segment, which is defined by v1 and v2
% So far this function is only worked for 2D case
% if isempty(varargin)
%     is3D = 0;
% else
%     is3D = varargin{1};
% end
% 
nPts = size(pt, 1);
d = abs([pt ones(nPts, 1)] * LINES');
divider = 1 ./ sqrt(LINES(:, 1).^2 + LINES(:, 2).^2);
d = bsxfun(@times, d, divider');