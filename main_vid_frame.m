function main_vid_frame
    mbyp_samples = [0.1,0.2,0.3,0.4,0.5];
    ip_arr = zeros(5,5);
    p = 768;
    figure
    hold all
    iter = 0;
    for m_count = 1:size(mbyp_samples,2)
        mbyp = mbyp_samples(m_count);
        iter = iter + 1;
        ip = video_frames(round(mbyp*p));
        ip_arr(:,iter) = ip;
    end
    plot(mbyp_samples, abs(ip_arr(1,:)), '-o')
    plot(mbyp_samples, abs(ip_arr(2,:)), '-o')
    plot(mbyp_samples, abs(ip_arr(3,:)), '-o')
    plot(mbyp_samples, abs(ip_arr(4,:)), '-o')
    plot(mbyp_samples, abs(ip_arr(5,:)), '-o')
    legend('PC1','PC2','PC3','PC4','PC5')
end