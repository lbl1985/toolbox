function hankelWindowSize = getHankelWindowSize(tmpFeature)
siz = size(tmpFeature);
hankelWindowSizeTrial = floor(sqrt(siz(1) * siz(2)));
if hankelWindowSizeTrial > siz(2)
    hankelWindowSizeTrial = 2;
end

tmpHankel = hankelConstruction(tmpFeature, hankelWindowSizeTrial);
[~, S, ~] = svd(tmpHankel);
tmpRank = robustRank(diag(S), 0.95, 0);
hankelWindowSize = siz(2) - tmpRank;