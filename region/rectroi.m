function roi = rectroi(I, rect)
% extract rect interested region
% Input:
% I:    original image
% rect: [r c height width]
% Output:
% roi:  Region of Interst
% Binlong Li    10 May 2012
if ndims(I) == 2
    roi = I(rect(1) : rect(1) + rect(3) -1, ...
        rect(2) : rect(2) + rect(4) -1);
elseif ndims(I) == 3
    roi = I(rect(1) : rect(1) + rect(3) -1, ...
        rect(2) : rect(2) + rect(4) -1, :);
end
