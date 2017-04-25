for m=10:10:40
    projection = @(M) M * inv(M' * M )* M';  
    p = 100;
    d=5;
    n=1000;
    sigma = diag([20, 15, 10, 8, 6]);
    eps=1;
    x_bar = rand(p,1)*10;
    V = normrnd(0,1,p,d);
    V_hat = V*sigma;
    W= normrnd(0,1,d,n);
    X_temp = V_hat*W;
    Z = normrnd(0,eps*eps, p,n);
    X = Z + repmat(x_bar,1,n) + X_temp;

    %X = normrnd(0,1,p,n);
    E = normrnd(0,1,p,m,n);
    s=zeros(p,1);
    C = zeros(p);
    for i=1:n
        px = (projection(E(:,:,i) )*X(:,i));
        s = s + px;
        C = C + px * px';
        %if (mod(i, 100) == 0)
        %    s/i
        %end
    end
    s=s/n;
    C = C/n;
    V_sig_V = C - (eps*eps*m/p)*eye(p);
    [V_new , sig]= eig(V_sig_V);
    avg =  x_bar;
    avg = avg*m/p;
    err1 = norm(avg-s)/norm(avg);
    err2 = dot(V_new(:,1),V(:,1))/(norm( V(:,1))*norm( V(:,1)))
    
end
 
 