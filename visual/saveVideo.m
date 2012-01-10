function saveVideo(vt, movieName)
fig1 = figure(1);
nFrame = size(vt.origVideo, 3);

aviobj = avifile(movieName, 'fps', 11, 'compression', 'none');
for t = 1 : nFrame
    figure(fig1);
    subplot(1, 3, 1); imshow(uint8(vt.origVideo(:, :, t)));
    title(['Frame ' num2str(t)]);
    subplot(1, 3, 2); imshow(uint8(vt.foreGround_MoG(:, :, t)));
%     subplot(1, 3, 3); imshow(uint8(vt.foreGround_RPCA(:, :, t)));
    subplot(1, 3, 3); imshow(vt.foreGround_RPCA(:, :, t));
    figure(fig1);
    pause(1/30);
    frame = getframe(fig1);
    aviobj = addframe(aviobj, frame);
    
end
aviobj = close(aviobj);