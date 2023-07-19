data = load('hw06-data1.mat');
X = data.X;
N = length(X);
X_norm = X - mean(X,2);
Sigma_linear = cov(transpose(X_norm));
[V_lin,W_lin] = eigs(Sigma_linear, 1);
proj_X_lin = transpose(V_lin) * X_norm;
histogram(proj_X_lin);
K = zeros(N);
for i = 1:N
    for j = 1:N
        K(i,j) = exp(-(1/50)*norm(X_norm(:,i) - X_norm(:,j))^2);
    end
end
[z, nu] = eigs(K, 1);
a = z/sqrt(nu);
proj_X_kernel = zeros(1,700);
for i = 1:N
    for j = 1:N
        proj_X_kernel(:,i) = proj_X_kernel(:,i) + a(j)*K(i,j);
    end
end
histogram(proj_X_kernel);
