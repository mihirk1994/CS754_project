function vecmax = eigenvec(E,X,d,n,p) 
    vecmax=zeros(p,d);
    C = zeros(p);
    for l =1:d
        for i=1:n
            px = projection(E(:,:) )*(X(:,i));
            C = C + px * px';
        end
        C = C/n;
        [vecmax(:,l) , v1 ]= eigs(C,1);
        coeff=zeros(i,1);
        for i=1:n
            coeff(i) = pinv(vecmax(:,l) )*X(:,i);
            X (:,i)= X (:,i) - coeff(i)*vecmax(:,l);
        end
         %x_bar = x_bar - pinv(vecmax(l) )*X(:,i)*vecmax(l)
        l
    end
 end