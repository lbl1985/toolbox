classdef videoSaver < handle
    %SAVEVIDEO Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        movieFile
        M
        frameRate
        clrmap
        aviobj
        
    end
    
    properties (SetAccess = public)
        fbeg = 1;
        fend
        fig
    end 
    
    methods
        function obj = videoSaver(requiredName, requiredFrameRate)
            if isempty(requiredName), obj.movieFile = 'trial1.avi';
            else obj.movieFile = requiredName;  end
            obj.frameRate = requiredFrameRate;
            obj.aviobj = avifile(obj.movieFile, 'fps', obj.frameRate, ...
                'compression', 'none');            
        end
        
        function obj = save(obj, inputVideo,varargin)
            obj.M = inputVideo;     nd = ndims(obj.M);
            obj.fig = figure;
            
            if isempty(varargin)
                obj.fbeg = 1;   obj.fend = size(inputVideo, ndims(inputVideo));
            else
                obj.fbeg = varargin{1}; obj.fend = varargin{2};
            end
            
            for t = obj.fbeg : obj.fend
                figure(obj.fig);
                if nd == 3
                    imshow(obj.M(:, :, t)); 
                else
                    imshow(obj.M(:, :, :, t)); 
                end
                title(['Frame ' num2str(t)]);   pause(1/22); 
                obj.saveCore();
            end
            obj.aviobj = close(obj.aviobj);
        end
        
        function saveClose(obj)
            obj.aviobj = close(obj.aviobj);
        end
            
        
        function obj = saveCore(obj)
            frame = getframe(obj.fig);
            obj.aviobj = addframe(obj.aviobj, frame);
        end
    end
end

