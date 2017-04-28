function C = video_reconstruction(X,p,m,n,d)

    projection = @(M) M * inv(M' * M )* M';    
    eps=1;
    %X = normrnd(0,1,p,n);
    %E = normrnd(0,1,p,m,n);
    C = zeros(p);
    for i=1:n
    px = projection(normrnd(0,1,p,m))*(X(:,i));
    C = C + px * px';
    end
    C = C/n;
    %V_est = eigenvec(E,X,d,n,p) ;
    
end