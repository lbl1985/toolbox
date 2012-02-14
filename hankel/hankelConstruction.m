function kHankel = hankelConstruction(FrameFeatures, HankelWindowSize)
% Input:    
% FrameFeature:     d x n , d is dimension of the input features. such as [
%                   x, y] location then d = 2;
%                   n: number of feature points.
% HankelWindowSize: as Named
% Binlong Li        2/7/2012

idx = hankel(1:HankelWindowSize, HankelWindowSize:size(FrameFeatures, 2));
k = FrameFeatures(:, idx);
kHankel = reshape(k, size(idx, 1) * size(k, 1), size(idx, 2));