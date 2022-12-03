clc;
clear all;

load('calibration_support.mat');

Irgb  = imread('Scripts/images/left_3.png'); 
intrinsics = stereoParams.CameraParameters1.Intrinsics;
prevI = undistortImage(rgb2gray(Irgb), intrinsics); 

% Detect features. 
prevPoints = detectSURFFeatures(prevI, 'MetricThreshold',500);

% Select a subset of features, uniformly distributed throughout the image.
numPoints = 200;
prevPoints = selectUniform(prevPoints, numPoints, size(prevI));

% Extract features. Using 'Upright' features improves matching quality if 
% the camera motion involves little or no in-plane rotation.
prevFeatures = extractFeatures(prevI, prevPoints, 'Upright',true);

% Add the first view. Place the camera associated with the first view
% at the origin, oriented along the Z-axis.
viewId = 1;
vSet = viewSet;
vSet = addView(vSet, viewId,'Orientation',eye(3), 'Location',[0,0,0], 'Points',prevPoints);


% Read second image:
Irgb  = imread('Scripts/images/left_7.png'); 
% Convert to gray scale and undistort.
I = undistortImage(rgb2gray(Irgb), intrinsics);

% Match features between the previous and the current image.
[currPoints, currFeatures, indexPairs] = helperDetectAndMatchFeatures(...
    prevFeatures, I);

% Estimate the pose of the current view relative to the previous view.
[Orientation, Location, inlierIdx] = helperEstimateRelativePose(...
    prevPoints(indexPairs(:,1)), currPoints(indexPairs(:,2)), intrinsics);

% Exclude epipolar outliers.
%indexPairs = indexPairs(inlierIdx, :);
viewId = 2;
vSet = addView(vSet, viewId,'Orientation',Orientation, 'Location',Location, 'Points', currPoints);
vSet = addConnection(vSet, 1, 2, 'Matches',indexPairs);

%%
% Setup axes.
figure
axis([-15, 15, -20, 20, 0, 80]);

% Set Y-axis to be vertical pointing down.
view(gca, 3);
set(gca, 'CameraUpVector',[0, -1, 0]);
camorbit(gca, -120, 0, 'data',[0, 1, 0]);

grid on
xlabel('X (cm)');
ylabel('Y (cm)');
zlabel('Z (cm)');
hold on

% Plot estimated camera pose. 
cameraSize = 1;
camPose = poses(vSet);
camEstimated = plotCamera(camPose, 'Size',cameraSize,...
    'Color',"g", 'Opacity',0);

% Initialize camera trajectories.
trajectoryEstimated = plot3(0, 0, 0, "r-");

legend('Estimated Trajectory');
title('Camera Trajectory');


%%
clc;
clear all;

load('calibration_support.mat');
intrinsics = stereoParams.CameraParameters1.Intrinsics;
Irgb  = imread('Scripts/images/left_1.png'); 
prevI = undistortImage(rgb2gray(Irgb), intrinsics); 

% Detect features. 
prevPoints = detectSURFFeatures(prevI, 'MetricThreshold',500);

% Select a subset of features, uniformly distributed throughout the image.
numPoints = 200;
prevPoints = selectUniform(prevPoints, numPoints, size(prevI));

% Extract features. Using 'Upright' features improves matching quality if 
% the camera motion involves little or no in-plane rotation.
prevFeatures = extractFeatures(prevI, prevPoints, 'Upright',true);

% Add the first view. Place the camera associated with the first view
% at the origin, oriented along the Z-axis.
viewId = 1;
vSet = viewSet;
vSet = addView(vSet, viewId,'Orientation',eye(3), 'Location',[0,0,0], 'Points',prevPoints);

% Read second image:
Irgb  = imread('Scripts/images/left_2.png'); 
% Convert to gray scale and undistort.
I = undistortImage(rgb2gray(Irgb), intrinsics);

% Match features between the previous and the current image.
[currPoints, currFeatures, indexPairs] = helperDetectAndMatchFeatures(...
    prevFeatures, I);

% Estimate the pose of the current view relative to the previous view.
[Orientation, Location, inlierIdx] = helperEstimateRelativePose(...
    prevPoints(indexPairs(:,1)), currPoints(indexPairs(:,2)), intrinsics);

% Exclude epipolar outliers.
%indexPairs = indexPairs(inlierIdx, :);
viewId = 2;
vSet = addView(vSet, viewId,'Orientation',Orientation, 'Location',Location, 'Points', currPoints);
vSet = addConnection(vSet, 1, 2, 'Matches',indexPairs);

for viewId = 3:6
    % Read and display the next image
    name = 'Scripts/images/left_' + string(viewId) + '.png'
    Irgb = imread(name);
    
    % Convert to gray scale and undistort.
    I = undistortImage(rgb2gray(Irgb), intrinsics);
    
    % Match points between the previous and the current image.
    [currPoints, currFeatures, indexPairs] = helperDetectAndMatchFeatures(...
        prevFeatures, I);
      
    % Eliminate outliers from feature matches.
    [~, inlierIdx] = helperEstimateRelativePose(prevPoints(indexPairs(:,1)),...
        currPoints(indexPairs(:, 2)), intrinsics);
    %indexPairs = indexPairs(inlierIdx, :);
    
    % Triangulate points from the previous two views, and find the 
    % corresponding points in the current view.
    [worldPoints, imagePoints] = helperFind3Dto2DCorrespondences(vSet,...
        intrinsics, indexPairs, currPoints);
    
    % Since RANSAC involves a stochastic process, it may sometimes not
    % reach the desired confidence level and exceed maximum number of
    % trials. Disable the warning when that happens since the outcomes are
    % still valid.
    warningstate = warning('off','vision:ransac:maxTrialsReached');
    
    % Estimate the world camera pose for the current view.
    absPose = estimateWorldCameraPose(imagePoints, worldPoints, intrinsics);
    
    % Restore the original warning state
    warning(warningstate)
    
    % Add the current view to the view set.
    vSet = addView(vSet, viewId, absPose, 'Points',currPoints);
    
    % Store the point matches between the previous and the current views.
    vSet = addConnection(vSet, viewId-1, viewId, 'Matches',indexPairs);    
    
    tracks = findTracks(vSet); % Find point tracks spanning multiple views.
        
    camPoses = poses(vSet);    % Get camera poses for all views.
    
    % Triangulate initial locations for the 3-D world points.
    xyzPoints = triangulateMultiview(tracks, camPoses, intrinsics);
    
    % Refine camera poses using bundle adjustment.
    [~, camPoses] = bundleAdjustment(xyzPoints, tracks, camPoses, ...
        intrinsics, 'PointsUndistorted',true, 'AbsoluteTolerance',1e-12,...
        'RelativeTolerance',1e-12, 'MaxIterations',200, 'FixedViewID',1);
        
    vSet = updateView(vSet, camPoses); % Update view set.
    
    % Bundle adjustment can move the entire set of cameras. Normalize the
    % view set to place the first camera at the origin looking along the
    % Z-axes and adjust the scale to match that of the ground truth.
    vSet = helperNormalizeViewSet(vSet, groundTruthPoses);
    
    % Update camera trajectory plot.
    helperUpdateCameraPlots(viewId, camEstimated, camActual, poses(vSet), ...
        groundTruthPoses);
    helperUpdateCameraTrajectories(viewId, trajectoryEstimated, ...
        trajectoryActual, poses(vSet), groundTruthPoses);
    
    prevI = I;
    prevFeatures = currFeatures;
    prevPoints   = currPoints;  
end
