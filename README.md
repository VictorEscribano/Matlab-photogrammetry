# 3D Reconstruction from stereo images

## Requirements
* Computer vision toolbox
* Webcam toolbox

## Introduction
This project focuses on 3D scene reconstruction by means of clasis photogrametry principles using MATLAB. To generate the poincloud the following steps will be done:
* Stereo camera calibration to know th intrinsic parameters of both cameras and the position of the right camera relative to the left (main) camera.
* Obtain set if images of the environment to recostruct.
* Use Structure from Motion (Visual odometry) to estimate the actual position of the left camera respect to the previous frame, and with the extrinsic parameters estimate also the right camera position relative to the new left camera transformation.
* Extract a 3D poincloud by means of triangulation for every camera pose.
* Fusion those pointclouds with different orientations using Iterative Closest Point (ICP) algorithm.
* (Extra) Extract 3D known shapes from the computed poincloud (spheres, cones, etc.)

![alt text](https://github.com/VictorEscribano/Computer-Vision-Project/blob/main/Introduction_report/Report%20images/camera_support.jpeg)

## Documentation
Documentation of this project can be found on:
* [Project_resume.pdf](https://github.com/VictorEscribano/Computer-Vision-Project/blob/main/Introduction_report/CV_Short_Project_Resume_Victor_Escribano_Oriol_Contreras.pdf)

## References
* [Monocular_odometry](https://es.mathworks.com/help/vision/ug/monocular-visual-odometry.html)
* [3D_Point_Cloud_Registration](https://es.mathworks.com/help/vision/ug/3-d-point-cloud-registration-and-stitching.html)
* [estgeotform3d](https://es.mathworks.com/help/vision/ref/estgeotform3d.html)
