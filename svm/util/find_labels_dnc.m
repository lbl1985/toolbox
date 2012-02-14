%this function labels data with kmeans result in batches/blocks, useful for removing memory requirements

function labels = find_labels_dnc(center,X)
% center dimension should be fixed as n x d;
% X      dimsnsion should be n x d
% However since X might be larget X might be n x d or d x n. 

blksize = 1e5;

% X might be huge matrix. However, center is always relative small matrix
% if center dimension should be equal to X dimenstion. 
% since size(center, 2) is feature dimension
isIdentical = isequal(size(center, 2), size(X, 2));

if isIdentical
    % X: n x d
    nr_desc = size(X, 1);
    labels = zeros(size(X, 1), 1);    
else
    % X: d x n
    nr_desc = size(X, 2);
    labels = zeros(size(X, 2),1);
end

nr_calculated = 0;
while(nr_calculated<nr_desc)
    nr_tocalc = min(nr_desc-nr_calculated, blksize);
    head = nr_calculated+1;
    tail = nr_calculated+nr_tocalc;
    if isIdentical
        % X: n x d
        X_blk = X(head:tail, :);   
    else
        % X: d x n
        X_blk = X(:, head:tail);
        X_blk = X_blk';
    end
    % findvword input should be 
    % center: n x d
    % X_blk:  n x d
    labels(head:tail) = findvword(center, X_blk);
    nr_calculated  = nr_calculated + nr_tocalc;
end

end