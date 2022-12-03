# 3D Reconstruction from stereo images

## Requirements
* Computer vision toolbox
* Webcam toolbox

## Introduction
This project focuses on 3D scene reconstruction by means of clasis photogrametry principles using MATLAB. To generate the poincloud the following steps will be done:
* Stereo camera calibration to extract the intrinsic parameters of both sensors and the position of the right camera relative to the left (main) one.
* Obtain a set of consecutive images of the environment to recostruct.
<img src="https://github.com/VictorEscribano/Computer-Vision-Project/blob/main/resources/camera%20position%20images.png" width="480">
* Use Structure from Motion (Visual odometry) to estimate the actual position of the left camera with respect to the previous frame, and with the extrinsic parameters estimate also the right camera position relative to the new left camera transformation.
<img src="https://github.com/VictorEscribano/Computer-Vision-Project/blob/main/resources/camera%20position.PNG" width="240">
* Extract a 3D poincloud by means of triangulation for every camera pose.
* Fusion those pointclouds with different orientations using Iterative Closest Point (ICP) algorithm.
* (Extra) Extract 3D known shapes from the computed poincloud (spheres, cones, etc.)

<img src="https://github.com/VictorEscribano/Computer-Vision-Project/blob/main/resources/Introduction_report/Report%20images/camera_support.jpeg" width="240">

## Documentation
Documentation of this project can be found on:
* [Project_resume.pdf](https://github.com/VictorEscribano/Computer-Vision-Project/blob/main/Introduction_report/CV_Short_Project_Resume_Victor_Escribano_Oriol_Contreras.pdf)

## References
* [Monocular odometry](https://es.mathworks.com/help/vision/ug/monocular-visual-odometry.html)
* [3D PointCloud Registration](https://es.mathworks.com/help/vision/ug/3-d-point-cloud-registration-and-stitching.html)
* [estgeotform3d](https://es.mathworks.com/help/vision/ref/estgeotform3d.html)
* [Structure from motion](https://es.mathworks.com/help/vision/ug/structure-from-motion-from-multiple-views.html)
