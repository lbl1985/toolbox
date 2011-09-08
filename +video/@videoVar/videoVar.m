classdef videoVar
    %Include all basic functionality may applied to a video varable in
    %Matalb
    %   properties  : 
    %       Data
    %       siz
    %       ndim
    %   methods      
    %       play    : play the Data
    %       save    : save the video as input name
    
    properties
        Data        
        siz 
        ndim
        nFrame
    end
    
    properties (SetAccess = public)
        videoName = [];
        videoOrigFolder =[];
    end
    
    methods
        function obj = videoVar(inputData)
            if nargin > 0
                obj.Data = inputData;
                obj.siz = size(obj.Data);
                obj.ndim = length(obj.siz);
                obj.nFrame = obj.siz(obj.ndim);
            end
        end        
    end   
end

