# 3D Reconstruction from stereo images

## Requirements
* Computer vision toolbox
* Webcam toolbox

## Introduction
This project focuses on 3D scene reconstruction by means of clasis photogrametry principles using MATLAB. To generate the poincloud the following steps will be done:

* Design a support for the stereo cameras to ensure the same external parameters in all images.
<p align="center">
  <img src="https://github.com/VictorEscribano/Computer-Vision-Project/blob/main/resources/Introduction_report/Report%20images/camera_support.jpeg" width="240">
</p>
* Stereo camera calibration to extract the intrinsic parameters of both sensors and the position of the right camera relative to the left (main) one.
<p align="center">
  
</p>
* Obtain a set of consecutive images of the environment to recostruct.
<p align="center">
  <img src="https://github.com/VictorEscribano/Computer-Vision-Project/blob/main/resources/camera%20position%20images.png" width="720">
</p>
* Use Structure from Motion (Visual odometry) to estimate the actual position of the left camera with respect to the previous frame, and with the extrinsic parameters estimate also the right camera position relative to the new left camera transformation.
<p align="center">
  <img src="https://github.com/VictorEscribano/Computer-Vision-Project/blob/main/resources/camera%20position.PNG" width="240">
</p>
* Extract a 3D poincloud by means of triangulation for every camera pose.
<p align="center">
  
</p>
* Fusion those pointclouds with different orientations using Iterative Closest Point (ICP) algorithm.
<p align="center">
  
</p>
* (Extra) Extract 3D known shapes from the computed poincloud (spheres, cones, etc.)



## Documentation
Documentation of this project can be found on:
* [Project_resume.pdf](https://github.com/VictorEscribano/Computer-Vision-Project/blob/main/Introduction_report/CV_Short_Project_Resume_Victor_Escribano_Oriol_Contreras.pdf)

## References
* [Monocular odometry](https://es.mathworks.com/help/vision/ug/monocular-visual-odometry.html)
* [3D PointCloud Registration](https://es.mathworks.com/help/vision/ug/3-d-point-cloud-registration-and-stitching.html)
* [estgeotform3d](https://es.mathworks.com/help/vision/ref/estgeotform3d.html)
* [Structure from motion](https://es.mathworks.com/help/vision/ug/structure-from-motion-from-multiple-views.html)
