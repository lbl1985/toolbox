function playM_asVideo(M, fbeg, fend, pause_time, clrmap)
% [3D & 4D] Used to play a stack of T images as a video. If the M is 2D
% image, the same as imagesc(M)
%
% NOTE: Can convert between MxNxT and MxNxPxT image stack.
%
% INPUTS
%   M           - The matrix with image stack.
%   fbeg        - [optional] Beginning frame to play as video (if empty = 1)
%   fend        - [optional] Endding frame(if empty then = end frame)
%   pause_time	- [optional] if empty = 22
%   clrmap      - [optional] if empty = 'jet'
%
% OUTPUTS
%
% EXAMPLE
%   load R
%   playM_asVideo(R, 1, 0, 3);
%   playM_asVideo(R, 70, 0, 3);
%
% DATESTAMP
%   23-Aug-2009  10:30pm
%
% See also IMAGESEC, saveM_asVideo

% Binlong Li's Video Toolbox      Version 0.01   
% Written and maintained by Binlong Li    li.b-at-neu.edu 
% Please email me if you find bugs, or have suggestions or questions! 
if iscell(M)
    n = length(M);
end
nd = ndims(M);
if (nargin < 2 || isempty(fbeg)),       fbeg = 1;           end
if (nargin < 3 || isempty(fend)),       fend = 0;           end
if (nargin < 4 || isempty(pause_time)), pause_time = 22;    end
if (nargin < 5 || isempty(clrmap)),     clrmap = 'jet';     end
if fend == 0,       fend = size(M, nd); end 

filename = inputname(1);

if (nd == 2)  
    imagesc(M); colormap(clrmap); colorbar;
    title(sprintf('%s', filename));
elseif (nd == 3)
    if ~iscell(M)
        for i = fbeg : fend
    %       imagesc(M(:, :, i - fbeg + 1)); colormap(clrmap);
%             imagesc(M(:, :, i)); colormap(clrmap); colorbar;
            imshow(M(:, :, i)); 
            title(sprintf('%s\nFrame%d', filename,  i));
            pause(1/pause_time);        
        end
    else
        for i = fbeg : fend
            for j = 1 : n
                subplot(1, n, i); 
                imagesc(M{j}(:, :, i)); colormap(clrmap); colorbar;
%                 imshow(M{j}(:, :, i));
                title(sprintf('%s\nFrame%d', filename,  i));
                pause(1/pause_time);
            end
        end
    end
elseif (nd == 4)
    for i = fbeg : fend
%       imagesc(M(:, :, :, i - fbeg + 1)); colormap(clrmap);
%         imagesc(M(:, :, :, i)); colormap(clrmap); colorbar;
        imshow(M(:, :, :, i));
        title(sprintf('%s\nFrame%d', filename, i));
        pause(1/pause_time);
    end
end