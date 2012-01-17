function saveImages_asVideo(moviefile, path, ext, fbeg, fend, framerate)

% INPUTS
%   moviefile   - Output video name. Eg, output.avi
%   path        - folder where the images live
%   ext         - ext for images
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
%   01-Feb-2010  18:20
%
% See also AVIFILE, IMAGESC, ADDFRAME, saveM_asVideo

% Binlong Li's Video Toolbox      Version 1.0   
% Written and maintained by Binlong Li    li.b-at-neu.edu 
% Please email me if you find bugs, or have suggestions or questions! 

if nargin < 4,  fbeg = 1;   end
if nargin < 5,  fend = 0;   end
if nargin < 6,  framerate = 29;     end

[srcdir filenames n] = rfdatabase(path, [], ext);

if fend == 0;   fend = n;   end

aviobj = avifile(moviefile, 'fps', framerate, 'compression', 'none');

for i = fbeg : fend
    imshow([srcdir filenames{i}]); title(['Frame ' num2str(i)]);    
    pause(1/framerate); 
    frame = getframe(gcf);
    aviobj = addframe(aviobj, frame);
end

aviobj = close(aviobj);