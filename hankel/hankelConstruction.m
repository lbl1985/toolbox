function kHankel = hankelConstruction(FrameFeatures, HankelWindowSize)

idx = hankel(1:HankelWindowSize, HankelWindowSize:size(FrameFeatures, 2));
k = FrameFeatures(:, idx);
kHankel = reshape(k, size(idx, 1) * size(k, 1), size(idx, 2));