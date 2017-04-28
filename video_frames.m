centreframe2 = zeros(41*92,1);
ind=1
    path=strcat('Datasets/ProcessedVideo-0830am-0845am-Cam45/ten-min-',int2str(ind),'.avi');
    path
    [frame,rate] = generate_video_frame_vector(path);
    mean = sum(frame,3)/size(frame,3);
    [size1, size2] = size (imresize(frame(:,:,1),0.1))
    centreframe = zeros(size1 ,...
        size2, size(frame,3));
    for i = 1:size(frame,3)
        centreframe(:,:,i) = imresize(frame(:,:,i) - mean, 0.1);
    end
    centreframe2_temp = reshape(centreframe, ...
    size(centreframe,1)* size(centreframe,2), ...
    size(centreframe,3) );
%    centreframe2 = cat(2, centreframe2, centreframe2_temp);
centreframe2 = centreframe2_temp ;
%%%%%%%%%%%%%%%%%%%%
d= 5;

p = size(centreframe2,1);
n =  size(centreframe2,2);
C_data=zeros(p);
'pre covar'
for i=1:n
C_data = C_data + centreframe2(:,i)*(centreframe2(:,i))';
end
C_data = C_data/n;

'pre eigenval'
[V_new , sig]= eig(C_data);
[sig,perm] = sort(diag(sig), 'descend');
V_new = V_new(:, perm);

V_new= V_new(:,1:d);
newdots=zeros(d,4);
for k = 1:1:4
'video recon'
m=k*500
C= video_reconstruction(centreframe2,p,m,n,d);

[V_rec , sig_rec]= eig(C);
[sig_rec,perm] = sort(diag(sig_rec), 'descend');
V_rec = V_rec(:, perm);

V_rec= V_rec(:,1:d);
'pre dot prod'

for i=1:d
  newdots(i,k) = dot(V_new(:,i),V_rec(:,i))/(norm( V_new(:,i))*norm( V_rec(:,i)));
end


end
 coeffs_rec = pinv(V_rec )*centreframe2;
 video_reconstructed_rec = V_rec*coeffs_rec;
 video_reconstructed_rec = reshape(video_reconstructed_rec,[41,92,599]);
 %displayvideo(video_reconstructed_rec, 0);
 
 coeffs_new = pinv(V_new )*centreframe2;
 video_reconstructed_new = V_new*coeffs_new;
  video_reconstructed_new = reshape(video_reconstructed_new,[41,92,599]);
 %displayvideo(video_reconstructed_new, 0);
 
 diffrec = centreframe - video_reconstructed_rec;
 diffnew = centreframe - video_reconstructed_new;

 newn = norm(sum(abs(diffnew),3))
 newr = norm(sum(abs(diffrec),3))
 den = norm ( sum(abs(centreframe),3) )
 