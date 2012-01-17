function saveM_asVideo(moviefile, M, fbeg, fend, framerate, clrmap)
% [3D & 4D] Used to save a stack of T images as a video. 
%
% NOTE: Can convert between MxNxT and MxNxPxT image stack.
%
% INPUTS
%   moviefile   - Output video name. Eg, output.avi
%   M           - The matrix with image stack.
%   fbeg        - [optional] Beginning frame to save as video (if empty = 1)
%   fend        - [optional] Endding frame(if 0 then = end frame)
%   framerate	- [optional] if [] = 29
%   clrmap      - [optional] if empty = 'jet'
%
% OUTPUTS
%
% EXAMPLE
%   load R
%   saveM_asVideo('R_jet_3.avi', R, 1, 0, 3, 'jet');
%
% DATESTAMP
%   03-Jun-2009  1:00am
%
% See also AVIFILE, IMAGESC, ADDFRAME

% Binlong Li's Video Toolbox      Version 0.01   
% Written and maintained by Binlong Li    li.b-at-neu.edu 
% Please email me if you find bugs, or have suggestions or questions! 
nd = ndims(M);
if nargin < 3,      fbeg = 1;               end
if nargin < 4,      fend = 0;               end
if nargin < 5,      framerate = 29;         end
if nargin < 6,      clrmap = 'jet';         end
if fend == 0,       fend = size(M, nd);     end 

filename = inputname(2);
aviobj = avifile(moviefile, 'fps', framerate, 'compression', 'none');


if (nd == 3)    
    for i = fbeg : fend
%         imagesc(M(:, :, i - fbeg + 1)); colormap(clrmap);
%         imagesc(M(:, :, i)); colormap(clrmap);  colorbar;
        imshow(M(:, :, i)); %colormap(clrmap);  colorbar;
        title(sprintf('%s\nFrame%d', filename, i));
        pause(1/22);
        frame = getframe(gcf);
        aviobj = addframe(aviobj, frame);
    end
elseif (nd == 4)
    for i = fbeg : fend
%         imagesc(M(:, :, :, i - fbeg + 1));  colormap(clrmap);
        imagesc(M(:, :, :, i));  colormap(clrmap);  colorbar;
        title(sprintf('%s\nFrame%d', filename, i));
        pause(1/22); 
        frame = getframe(gcf);
        aviobj = addframe(aviobj, frame);
    end
end
aviobj = close(aviobj);