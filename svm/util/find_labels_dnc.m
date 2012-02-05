%this function labels data with kmeans result in batches/blocks, useful for removing memory requirements

function labels = find_labels_dnc(center,X)

blksize = 1e5;
nr_desc = size(X, 1);

% X might be huge matrix. However, center is always relative small matrix
% if center dimension should be equal to X dimenstion. 
isIdentical = isequal(size(center, 1), size(X, 1));

if isIdentical
    labels = zeros(size(X, 2), 1);    
else
    labels = zeros(size(X, 1),1);
end

nr_calculated = 0;
while(nr_calculated<nr_desc)
    nr_tocalc = min(nr_desc-nr_calculated, blksize);
    head = nr_calculated+1;
    tail = nr_calculated+nr_tocalc;
    if isIdentical
        X_blk = X(:, head:tail);
        X_blk = X_blk';
    else
        X_blk = X(head:tail,:);
    end
    labels(head:tail) = findvword(center, X_blk);
    nr_calculated  = nr_calculated + nr_tocalc;
end

end