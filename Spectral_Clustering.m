data = load('hw06-data2.mat');
X = data.X;
M = 8;
symbols = ['x', 'o', '+', '_', '*', 's', '^', 'd'];
clusters = {X}; % Cell array
image_name = "spectral_clustering_data_2_M_";
while(length(clusters) < M)
    new_clusters = {};
    for c = 1:length(clusters)
        N = length(clusters{:,c});
        W = zeros(N);
        for i = 1:N
            for j = 1:N
                if i==j
                    continue
                end
                W(i,j) = exp((-1*norm(clusters{:,c}(:,i) - clusters{:,c}(:,j))^2) / 10);
            end
        end
        D = zeros(N);
        for i = 1:N
            D(i,i) = sum(W(:,i));
        end
        [V, Lambda] = eigs((D^(-0.5))*(D-W)*(D^(-0.5)), 2, 'smallestabs');
        z2 = V(:,2);

        labels = sign(D^(-0.5) * z2);

        idx1 = find(labels == -1);
        idx2 = find(labels == 1);
        new_clusters(end+1) = {clusters{:,c}(:,idx1)};
        new_clusters(end+1) = {clusters{:,c}(:,idx2)};
    end
    clusters = new_clusters;
    
    J = 0; % Overall Cost
    for k = 1:length(clusters)
       points = clusters{:,k};
       x = points(1,:);
       y = points(2,:);
       cost=0;
       for u = 1:length(points)
           for v = 1:length(points)
               cost = cost + norm(points(:,u) - points(:,v))^2;
           end
       end
       J = J + cost/length(points);
       scatter(x, y, symbols(k));
       hold on
    end
    J = 0.5*J
    
    filename = append(image_name, int2str(length(clusters)));
    saveas(gcf, filename, 'png');
    clf();    
end
