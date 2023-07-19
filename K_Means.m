data = load('hw06-data2.mat');
X = data.X;
M_list = [2, 3, 4, 5, 6, 7, 8];
symbols = ['x', 'o', '+', '_', '*', 's', '^', 'd'];


for M = M_list
    r = randperm(length(X), M);
    means = X(:, r); % initial means
    L = length(X);
    N = 100;
    labels = zeros(L,1);
    cluster_sizes = zeros(M,1);
    image_name = "k_means_data_2_M_";
    for i = 1:N
        for j = 1:L
            distances = [];
            for k = 1:M
               distances(end + 1) = norm(X(:,j) - means(:,k)); % Find distances from cluster means 
            end
            [~, labels(j)] = min(distances);
        end
        means = zeros(size(means));
        for k= 1:M
           idx = find(labels == k);
           means(:,k) = mean(X(:, idx), 2);
        end
    end

    J = 0; % Overall Cost
    for k = 1:M
       cost = 0; % Cluster-wise cost
       idx = find(labels == k);
       for u = 1:length(idx)
           for v = 1:length(idx)
               cost = cost + norm(X(:,idx(u)) - X(:,idx(v)))^2;
           end
       end
       J = J + cost/length(idx);
       scatter(X(1, idx), X(2, idx), symbols(k));
       hold on
    end
    J = 0.5*J
    filename = append(image_name, int2str(M));
    saveas(gcf, filename, 'png');
    clf();
end