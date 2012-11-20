function [r1 r2] = boxOverlapRate(box1, box2)
% Toolbox level function
% calculate box overlap rate between box1 and box2. 
% Since between two boxes, the number of overlap pixel should be constant,
% however, compare to different box area, the rate should be different. 
% Therefore, output will be the rate relative to box1 and box2,
% respectively.
% Input:
% box1:         box information, consistent with rectangle function
%               format [x y w h]
% box2:         Same as box1
% Output: 
% r1:           Overlap rate relative to box1
% r2:           Overlap rate relative to box2
% Binlong Li    Friday   16-Nov-12  9:40AM
% Bug fixed: prod(pos(1, 3:4)) ->  prod(box1(3:4)) 
% Binlong Li    Tuesday   20-Nov-12 10:28AM
pos = [box1(1:2) box1(1:2) + box1(3:4) - 1; ...
        box2(1:2) box2(1:2) + box2(3:4) - 1];
pos = pos(:, [2 1 4 3]);
res = max(pos, [], 1);
res = res([3 4]) + 10;

Canvas = zeros([res 2]);
ind = cell(2, 1);
for i = 1 : 2
    Canvas(pos(i, 1):pos(i, 3), pos(i, 2) : pos(i, 4), i) = 1;
    ind{i} = find(Canvas(:, :, i));
end

inter = intersect(ind{1}, ind{2});
r1 = numel(inter) / prod(box1(3:4));
r2 = numel(inter) / prod(box2(3:4));