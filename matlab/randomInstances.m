function Xtrain_raw_sub = randomInstances(trainFeature, criterionNum, seed)
% Input:
% trainFeature: Input Feature array with column wises features.
% criterionNum: artifical number of criterion you may need to sampling.
% Output:
% Xtrain_raw_sub: Random sampled instances matrix
% Related: kmeansPackage.m
% Author: Binlong Li    30 Sep 2011

tot_num_samples = size(trainFeature, 2);

fprintf('total number of training samples: %d\n', tot_num_samples);

criterionNum = [criterionNum tot_num_samples];

sub_size = min(criterionNum);

fprintf('kmeans on number of samples: %d\n', sub_size);

rand('state', seed);

ridx = randperm(tot_num_samples);
ridx = ridx(1:sub_size);

line = false(tot_num_samples, 1);
line(ridx) = true;

Xtrain_raw_sub = trainFeature(:, line);