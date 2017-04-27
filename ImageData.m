p=100;
%p=279;
d=5;
n=452;
m=40;
arrData=load('arrhythmia.mat')
arrData.X = (arrData.X)'
arrData.X=arrData.X(1:p,:)
arrData.X(~isfinite(arrData.X))=0;

CMat=cov(arrData.X);

[Varr,sigarr] = eig(CMat);
[sigarr,perm] = sort(diag(sigarr), 'descend');
Varr = Varr(:, perm);
V_red =  Varr(:,1:d);
sig_red= sigarr(perm);
sig_red=sig_red(1:d);
C_PCA = V_red*diag(sig_red)*V_red';

E=normrnd(0,1,p,m,n);
X_proj=zeros(p,n);
for i = 1:n
    X_proj(:,i)=projection(E(:,:,i)) * arrData.X(:,i);
end


CMat_proj=cov(Xproj);

[Varr_proj,sigarr_proj] = eig(CMat_proj);
[sigarr_proj,perm] = sort(diag(sigarr_proj), 'descend');
Varr_proj = Varr_proj(:, perm);
V_red_proj =  Varr_proj(:,1:d);
sig_red_proj= sigarr(perm);
sig_red_proj=sig_red_proj(1:d);
C_PCA_proj = V_red_proj*diag(sig_red_proj)*V_red_proj';


newdots=zeros(d,1);
for i=1:d
  newdots(i) = dot(V_red(:,i),V_red_proj(:,i))/(norm( V_red(:,i))*norm( V_red_proj(:,i)));
end
plot(abs(newdots))