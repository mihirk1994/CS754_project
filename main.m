n_samples = [500,1000,2000,5000,10000];
m_samples = [10,15,20,30,40];
nce_arr = zeros(5,1);
p = 100;
eps = 1;
figure
hold all
% subplot(2,2,1)
for n_count = 1:size(n_samples,2)
    n = n_samples(n_count);
    iter = 0;
    for m_count = 1:size(m_samples,2)
        m = m_samples(m_count);
        iter = iter + 1;
        [nce, ip] = pca_cs(m,n,eps);
        nce_arr(iter) = nce;
    end
    plot(m_samples/p, nce_arr, '-o')
    xlabel('Measurement ratio m/p')
    ylabel('Normalised Centre Error')
    disp(n)
end
legend('n=500','n=1000','n=2000','n=5000','n=10000')

hold off
figure
hold all
% Plotting inner product vs m/p
iter = 0;
n = 1000;
ip_arr = zeros(5,5);
for m_count = 1:size(m_samples,2)
    m = m_samples(m_count);
    iter = iter + 1;
    [nce, ip] = pca_cs(m,n,eps);
    ip_arr(:,iter) = ip;
end
% subplot(2,2,2)
plot(m_samples/p, abs(ip_arr(1,:)), '-o')
plot(m_samples/p, abs(ip_arr(2,:)), '-o')
plot(m_samples/p, abs(ip_arr(3,:)), '-o')
plot(m_samples/p, abs(ip_arr(4,:)), '-o')
plot(m_samples/p, abs(ip_arr(5,:)), '-o')
legend('PC1','PC2','PC3','PC4','PC5')
xlabel('Measurement ratio m/p')
ylabel('Inner product')


hold off
figure
hold all
% Plotting inner product vs m/p
iter = 0;
m = 20;
ip_arr = zeros(5,5);
for n_count = 1:size(n_samples,2)
    n = n_samples(n_count);
    iter = iter + 1;
    [nce, ip] = pca_cs(m,n,eps);
    ip_arr(:,iter) = ip;
end
% subplot(2,2,2)
plot(n_samples, abs(ip_arr(1,:)), '-o')
plot(n_samples, abs(ip_arr(2,:)), '-o')
plot(n_samples, abs(ip_arr(3,:)), '-o')
plot(n_samples, abs(ip_arr(4,:)), '-o')
plot(n_samples, abs(ip_arr(5,:)), '-o')
legend('PC1','PC2','PC3','PC4','PC5')
xlabel('Number of samples n')
ylabel('Inner product')


hold off
figure
hold all
% Plotting inner product vs m/p
iter = 0;
m = 20;
n = 1000;
ip_arr = zeros(5,5);
eps_samples = [1e-4, 1e-3, 1e-2, 1e-1, 1];
for eps_count = 1:size(eps_samples,2)
    eps = eps_samples(eps_count);
    iter = iter + 1;
    [nce, ip] = pca_cs(m,n,eps);
    ip_arr(:,iter) = ip;
end
% subplot(2,2,2)
sig1 = 20;
semilogx(eps_samples/sig1, abs(ip_arr(1,:)), '-o')
semilogx(eps_samples/sig1, abs(ip_arr(2,:)), '-o')
semilogx(eps_samples/sig1, abs(ip_arr(3,:)), '-o')
semilogx(eps_samples/sig1, abs(ip_arr(4,:)), '-o')
semilogx(eps_samples/sig1, abs(ip_arr(5,:)), '-o')
legend('PC1','PC2','PC3','PC4','PC5')
xlabel('eps/sig1')
ylabel('Inner product')
