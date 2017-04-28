function ip = video_frames(m)

% centreframe2 = zeros(41*92,1);
centreframe2 = zeros(24*32,1);
ind=1
    path=strcat('ten-min-',int2str(ind),'.avi');
    path
    [frame,rate] = generate_video_frame_vector(path);
    mean = sum(frame,3)/size(frame,3);
    [size1, size2] = size (imresize(frame(:,:,1),[24 32]))
    centreframe = zeros(size1 ,...
        size2, size(frame,3));
    for i = 1:size(frame,3)
        centreframe(:,:,i) = imresize(frame(:,:,i) - mean, [24 32]);
    end
    centreframe2_temp = reshape(centreframe, ...
    size(centreframe,1)* size(centreframe,2), ...
    size(centreframe,3) );
%    centreframe2 = cat(2, centreframe2, centreframe2_temp);
centreframe2 = centreframe2_temp ;
%%%%%%%%%%%%%%%%%%%%
d= 5;
% m=100;
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

V_new= V_new(1:d,:);
'video recon'
C= video_reconstruction(centreframe2,p,m,n,d);

[V_rec , sig_rec]= eig(C);
[sig_rec,perm] = sort(diag(sig_rec), 'descend');
V_rec = V_rec(:, perm);

V_rec= V_rec(1:d,:);
'pre dot prod'
newdots=zeros(d,1);
for i=1:d
  newdots(i) = dot(V_new(:,i),V_rec(:,i))/(norm( V_new(:,i))*norm( V_rec(:,i)));
end
ip = newdots;
end