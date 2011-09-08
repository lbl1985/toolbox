function saveAsVideo( obj, varargin )
%subfunction for videoVar, just simply save the videoVar data as Video
%   Detailed explanation goes here
    if nargin > 1
        filename = varargin{1};
        frameRate = 11;
    elseif nargin > 2
        [filename, frameRate] = varin2out(varargin);
    end
    s1 = videoSaver(filename, frameRate);
    s1.save(obj.Data);
end