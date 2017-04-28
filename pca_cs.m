function [nce, ip] = pca_cs(m,n,eps)
    projection = @(M) M * inv(M' * M )* M';  
    
    p = 100;
    d=5;
    %n=1000;
    sigma = diag([20, 15, 10, 8, 6]);
%     eps=1;
    x_bar = rand(p,1)*10;
    V = normrnd(0,1,p,d);
    V_hat = V*sigma;
    W= normrnd(0,1,d,n);
    X_temp = V_hat*W;
    Z = normrnd(0,eps*eps, p,n);
    X = Z + repmat(x_bar,1,n) + X_temp;
    
    C_orig = 0;
    for i = 1:size(X,2)
        C_orig = C_orig + (X(:,i)-x_bar)*(X(:,i)-x_bar)';
    end
    [V_orig , sig]= eig(C_orig);
    [sig, perm] = sort(diag(sig), 'descend');
    V_orig = V_orig(:, perm);
    V_orig = V_orig(1:d,:);
    
    %X = normrnd(0,1,p,n);
    E = normrnd(0,1,p,m,n);
    s=zeros(p,1);
    C_proj = 0;
    for i=1:n
        proj = projection(E(:,:,i) )*X(:,i);
        s = s + (proj);
    end
    s=(s/n);
    for i=1:n
        proj = projection(E(:,:,i) )*X(:,i)-s;
        C_proj = C_proj + proj*proj';
    end
    [V_proj , sig_proj]= eig(C_proj);
    [sig_proj,perm] = sort(diag(sig_proj), 'descend');
    V_proj = V_proj(:, perm);
    V_proj= V_proj(1:d,:);

    avg =  x_bar;
    avg = avg*m/p;
    nce = norm(avg-s)/norm(avg);
    ip = zeros(d,1);
    for i = 1:d
        ip(i) = abs(dot(V_orig(:,i),V_proj(:,i))/(norm( V_orig(:,i))*norm( V_proj(:,i))));
    end
end
 