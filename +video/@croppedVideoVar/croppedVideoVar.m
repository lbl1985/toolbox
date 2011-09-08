classdef croppedVideoVar < video.videoVar
    %Crop the video data according to specified spatial_size parameter.
    
    properties
        spatial_size
        temporal_size
        croppedVideo
        croppedSiz
        
        OrigBackup
    end
    
    methods
        function obj = croppedVideoVar(inputData, fovea)
            obj = obj@video.videoVar(inputData);
            obj.spatial_size = fovea.spatial_size;
            obj.temporal_size = fovea.temporal_size;
            obj.croppedVideo = uint8(zeros(floor(size(inputData, 1) / fovea.spatial_size) ...
                * fovea.spatial_size, floor(size(inputData, 2) / fovea.spatial_size) ...
                * fovea.spatial_size, size(inputData, 3), size(inputData, 4)));
            obj.croppedSiz = size(obj.croppedVideo);
        end        
    end
    
    methods
        function obj = cropVideoForFeatureDetection(obj)
            obj = obj.cropVideoForFeatureDetectionInTime();
            if obj.ndim == 3
                % do operation for gray images
                for t = 1 : obj.croppedSiz(end)
                    obj.croppedVideo(:, :, t) = obj.Data(1 : floor(obj.siz(1)/obj.spatial_size) * obj.spatial_size, ...
                        1 : floor(obj.siz(2) / obj.spatial_size) * obj.spatial_size, t);
                end
            elseif obj.ndim == 4
                % do operation for color images
                for t = 1 : obj.croppedSiz(end)
                    obj.croppedVideo(:, :, :, t) = obj.Data(1 : floor(obj.siz(1)/obj.spatial_size) * obj.spatial_size, ...
                        1 : floor(obj.siz(2) / obj.spatial_size) * obj.spatial_size, :, t);
                end
            end
            % After Processing
            obj = backupOrigVideo(obj);
            obj = fitCroppedIntoSlot(obj);
        end
        
        function obj = calculateSizeOfFeatureDetection(obj)
            % without really cropping the video, only calcuate the video
            % size after cropping. This function is not used for
            % visualization only for export to featureIndex class 
            obj.croppedVideo = [];
            obj.croppedSiz = [];
            obj.siz = [floor(obj.siz(1) / obj.spatial_size) * obj.spatial_size ...
                floor(obj.siz(2) / obj.spatial_size) * obj.spatial_size ...
                floor(obj.nFrame/obj.temporal_size) * obj.temporal_size];
            if obj.ndim == 4
                obj.siz = [obj.siz(1) obj.siz(2) 3 obj.siz(3)];
            end
            obj.Data = [];
            obj.nFrame = obj.siz(end);
        end
    end
    
    methods % Utility Function
        function obj = cropVideoForFeatureDetectionInTime(obj)
            obj.croppedSiz(end) = floor(obj.nFrame/obj.temporal_size) * obj.temporal_size;
            if obj.ndim == 3
                obj.croppedVideo = obj.croppedVideo(:, :, 1 : obj.croppedSiz(end));
            else
                obj.croppedVideo = obj.croppedVideo(:, :, :, 1 : obj.croppedSiz(end));
            end
        end
        
        function obj = backupOrigVideo(obj)
            obj.OrigBackup.Data = obj.Data;
            obj.OrigBackup.siz = obj.siz;
            obj.OrigBackup.ndim = obj.ndim;
            obj.OrigBackup.nFrame = obj.nFrame;
        end
        
        function obj = fitCroppedIntoSlot(obj)
            obj.Data = obj.croppedVideo;
            obj.siz = size(obj.Data);
            obj.nFrame = obj.siz(end);
            
            obj.croppedVideo = [];
            obj.croppedSiz = [];
        end
        
    end
end

