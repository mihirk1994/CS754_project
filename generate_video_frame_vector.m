function [ vid, framerate ] = generate_video_frame_vector( vid_file )
a = mmread(vid_file,[],[],false,true,'',false,true);
framerate = a.rate;
vid = zeros(a.height,a.width,a.nrFramesTotal);


for i=1:a.nrFramesTotal 
    vid(:,:,i) = rgb2gray(a.frames(i).cdata); 
end

end
