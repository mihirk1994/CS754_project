n_samples = [500,1000,2000,5000,10000];
m_samples = 10:10:40;
nce_arr = zeros(4,1);
p = 100;
figure
hold all
for n_count = 1:size(n_samples,2)
    n = n_samples(n_count);
    iter = 0;
    for m_count = 1:size(m_samples,2)
        m = m_samples(m_count);
        iter = iter + 1;
        nce = pca_cs(m,n);
        nce_arr(iter) = nce;
    end
    plot(m_samples/p, nce_arr, '-o')
    disp(n)
end
legend('n=500','n=1000','n=2000','n=5000','n=10000')