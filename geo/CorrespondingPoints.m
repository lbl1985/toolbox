classdef CorrespondingPoints < handle
    % Class designed for Corresponding Points Searching.
    % fRegion:  1 x 2 cell, each column stands for one filter out region
    %           each cell contains 2n x 2 matrix. 
    %           1st col for cols number
    %           2nd col for rows number
    %           1st row for [cols rows] of lefttop corner
    %           2nd row for [cols rows] of rightbottom corner
    %           each cell correspoinding to one region you want to avoid
    %           (Optional) fRegion could be empty
    %
    % Public Interfaces:
    %
    % Constructor:
    %   Input:
    %           filterOut:  as explained in fRegion
    %           frame1:     left corresponding image
    %           frame2:     right corresponding image
    %
    % getCorr_man:  get Corresponding Points by manually labeling
    %
    % getCorr:      getCorr depend on SURF feature and FlannBased Matching
    %
    % getMatches: 
    %   Output: 
    %           cor1:       corresponding points in left
    %           cor2:       corresponding points in right
    %
    % saveMatches: 
    %   Input:
    %           saveName:   (optional) default name: corrPoints.mat    
    %
    % Related: EpipoleGeometry.m
    % Author: Binlong Li,   28 Sep 2012     20:40
    properties (Access = private)
        % image specific data
        frame1 = [];
        keypoints1 = [];
%         keypoints1_arr = [];
        descriptors1 = [];
        
        
        frame2 = [];
        keypoints2 = [];
%         keypoints2_arr = [];
        descriptors2 = [];
        
        % matching related properties
        width = 0; 
        matcher;   
        matches = 0;
        
        cor1 = [];
        cor2 = [];
        
        % filter Out Region information
        
        fRegion = [];
        
        % saving name
        savingName = 'corrPoints.mat';
    end
    
    methods (Access = public)
        % Constructor function Depend on whether we need to filterOut
        % certain area.
        % frame1 and frame2 are two input frames
        function obj = CorrespondingPoints(filterOut, frame1, frame2, varargin)
            if ~isempty(filterOut)
                obj.fRegion = filterOut;
            end
            obj.frame1 = frame1;
            obj.frame2 = frame2;
        end
        
        % get Corresponding points by manually select 8 points
        function obj = getCorr_man(obj)
            frame = [obj.frame1 obj.frame2];
            obj.width = size(obj.frame1, 2);
            figEpi = figure();
            figure(figEpi); imshow(frame);
            
            cor_left = zeros(8, 2);     cor_right = zeros(8, 2);
            for i = 1 : 16
                if mod(i, 2) == 1
                    display('select point in left image');
                    [x y] = ginput(1);
                    cor_left(ceil(i/2), :) = [x y];
                    display(cor_left(ceil(i/2),:));
                    figure(figEpi);
                    hold on
                    plot(cor_left(ceil(i/2), 1), cor_left(ceil(i/2), 2), 'r*');
                    hold off
                else
                    display('select point in right image');
                    [x y] = ginput(1);
                    cor_right(ceil(i/2), :) = [x - obj.width y];
                    display(cor_right(ceil(i/2),:));
                    figure(figEpi);
                    hold on
                    plot(cor_right(ceil(i/2), 1) + obj.width, cor_right(ceil(i/2), 2), 'r*');
                    hold off
                end
            end
            save epipoleCor cor_left cor_right;
            obj.cor1 = cor_left;    obj.cor2 = cor_right;
        end
        
        % getCorr depend on SURF feature and FlannBased Matching
        function obj = getCorr(obj)
            obj.width = size(obj.frame1, 2);
            [obj.keypoints1 obj.descriptors1] = cv.SURF(obj.frame1);
            [obj.keypoints2 obj.descriptors2] = cv.SURF(obj.frame2);
            
            if ~isempty(obj.fRegion)
                filterOutPoints(obj);
            end
            
            obj.matcher = cv.DescriptorMatcher('FlannBased');
            obj.matcher.add(obj.descriptors1);
            obj.matcher.train();
            obj.matches = obj.matcher.match(obj.descriptors2);
            
            findMatches(obj);
            
        end
        
        % get Matches 
        function [cor1 cor2] = getMatches(obj)
            cor1 = obj.cor1;
            cor2 = obj.cor2;
        end
        
        % save Matches
        function saveMatches(obj, varargin)
            if ~isempty(varargin)
                obj.savingName = varargin{1};
            end
            cor1 = obj.cor1;    cor2 = obj.cor2;
            save(obj.savingName, 'cor1', 'cor2');            
        end
        
    end
    
    methods(Access = private)
        function findMatches(obj)
            distance = structField2Vector(obj.matches, 'distance');
            % Because the Idx is returned from C++, it's 0 based. need to
            % convert to 1 based.
            queryIdx = structField2Vector(obj.matches, 'queryIdx') + 1;
            trainIdx = structField2Vector(obj.matches, 'trainIdx') + 1;
            keypoints1_arr = structField2Vector(obj.keypoints1, 'pt');
            keypoints2_arr = structField2Vector(obj.keypoints2, 'pt');

            ind = find(distance <= 2 * min(distance));
            queryIdx = queryIdx(ind);
            trainIdx = trainIdx(ind);

            obj.cor1 = keypoints1_arr(trainIdx, :);
            obj.cor2 = keypoints2_arr(queryIdx, :);
        end
        
        function filterOutPoints(obj)
            kp1_arr = structField2Vector(obj.keypoints1, 'pt');
            kp2_arr = structField2Vector(obj.keypoints2, 'pt');
            
            ind1 = filterOutInOneImage(obj, kp1_arr, obj.fRegion{1});            
            ind2 = filterOutInOneImage(obj, kp2_arr, obj.fRegion{2});
            
            obj.keypoints1 = obj.keypoints1(ind1);
            obj.keypoints2 = obj.keypoints2(ind2);
            obj.descriptors1 = obj.descriptors1(ind1, :);
            obj.descriptors2 = obj.descriptors2(ind2, :);           
            
        end
        
        function ind = filterOutInOneImage(obj, kp, region)
            indicator = true(size(kp, 1), 1);
            
            nRegion = size(region, 1) /2;
            for i = 1 : nRegion                
                k1 = kp(:, 1) >= region(2*i-1, 1);
                k2 = kp(:, 1) <= region(2*i, 1);
                k3 = kp(:, 2) >= region(2*i-1, 2);
                k4 = kp(:, 2) <= region(2*i, 2);
                
                tmpIndicator = k1 & k2 & k3 & k4;
                tmpIndicator = ~tmpIndicator;
                indicator = indicator & tmpIndicator;
            end
            ind = find(indicator);   
        end
    end
end