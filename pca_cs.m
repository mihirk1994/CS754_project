
    m=20
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
    %E = normrnd(0,1,p,m,n);
    E = double(rand(p,m,n)>0.5);
    E1 = normrnd(0,1,p,m);
    s=zeros(p,1);
    C = zeros(p);
    for i=1:n
        px = (projection(E(:,:,i) )*X(:,i));
        s = s + px;
       
        %if (mod(i, 100) == 0)
        %    s/i
        %end
    end
    s=s/n;
    
    for i=1:n
    px = (projection(E(:,:,i) )*(X(:,i) - x_bar));
    C = C + px * px';
    end
    C = C/n;
    
    V_sig_V = C - (eps*eps*m/p)*eye(p);
    [V_new , sig]= eig(V_sig_V);
    [sig,perm] = sort(diag(sig), 'descend');
    V_new = V_new(:, perm);
    avg =  x_bar;
    avg = avg*m/p;
    err1 = norm(avg-s)/norm(avg);
    dotprods = zeros(d,1)
    for i=1:d
       dotprods(i)  = dot(V_new(:,i),V(:,i))/(norm( V(:,i))*norm( V_new(:,i)))
    end
    k1 = (m^2)/(p^2 )+ 2*m*(p-m)/(p^3 + 2*p^2);
    k2 = m/p -k1;
    sumsig=0;
    for j = 1:d
        sumsig = sumsig + (sigma(j,j)^2);
    end
    signew=zeros(p);
    for j= 1:d
        signew(j) = sigma(j,j)^2*k1 + (sumsig - sigma(j,j)^2)*k2/(p-1);
    end
    for j = d:p
        signew(j) = sumsig*k2/(p-1);
    end
    for i =1:d
        sigma(i,i)/signew(i)
    end
    X_old = X;
    X = X - repmat(x_bar,1,n);
    V_est = eigenvec(E,X,d,n,p) ;
    
    newdots=zeros(d,1);
    for i=1:d
      newdots(i) = dot(V_est(:,i),V(:,i))/(norm( V(:,i))*norm( V_est(:,i)));
    end
    newdots
    dotprods
    
    