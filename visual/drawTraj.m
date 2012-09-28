function drawTraj(traj)
% traj: n x 2 matrix, n = 1, stands for beginning, n = end, stands for
% ending.
% The Drawed trajectory will be with blue line and red star at the end
% point.
%
% Trial Code, also illustrate the relationship between coordinates
% a = [ 10 20; 20 40; 40 80; 80 160; 160 320];
% imshow('~/Desktop/lena.jpg')
% figure(gcf); 
% hold on; 
% line(a(:, 1), a(:, 2)); plot(a(end, 1), a(end, 2), 'r*');
% hold off; 
% figure(fig); hold on; 
line(traj(:, 1), traj(:, 2)); plot(traj(end, 1), traj(end, 2), 'r*', 'MarkerSize', 10);
% line(traj(:, 2), traj(:, 1)); plot(traj(end, 2), traj(end, 1), 'r*');
% hold off;