for m = 10:10:40
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
     X = Z + repmat(x_bar,1,n) + X;

     %X = normrnd(0,1,p,n);
     E = normrnd(0,1,p,m,n);
     s=zeros(p,1);
     for i=1:n
         s = s + (projection(E(:,:,i) )*X(:,i));
         %if (mod(i, 100) == 0)
         %    s/i
         %end
     end
     s=s/n;
     avg =  x_bar;
     avg = avg*m/p;
     norm(avg-s)/norm(s)
end
 
 