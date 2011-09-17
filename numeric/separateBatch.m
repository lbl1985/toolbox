function [clusterFeature clusterIndicesOut] = separateBatch(batchFeature, clusterIndices)
% batchFeature: feature should be column wised
nItems = length(clusterIndices);
nFeatureForEach = zeros(nItems, 1);
for i = 1 : nItems
    nFeatureForEach(i) = clusterIndices{i}.end - clusterIndices{i}.start + 1;
end

featureEndIndexForEach = cumsum(nFeatureForEach);
featureEndIndexForEach = [0; featureEndIndexForEach];
% clusterFeatureNum = calculateClusterFeatureNum(clusterIndices, nItems);

clusterFeature = zeros(size(batchFeature, 1), featureEndIndexForEach(end));
clusterIndicesOut = cell(nItems, 1);

% clusterFeature(:, 1 : featureEndIndexForEach(1)) = batchFeature(:, clusterIndices{1}.start : clusterIndices{1}.end);

for i =2 : nItems + 1
    clusterIndicesOut{i-1}.start = featureEndIndexForEach(i-1) + 1;
    clusterIndicesOut{i-1}.end = featureEndIndexForEach(i);
    clusterFeature(:, clusterIndicesOut{i-1}.start : clusterIndicesOut{i-1}.end) ...
        = batchFeature(:, clusterIndices{i - 1}.start : clusterIndices{i - 1}.end);
end

