# 3D Reconstruction from stereo images

## Requirements
* Matlab
* Computer vision toolbox
* Webcam toolbox
* 2 Webcams
* Calibration checkboard

## Introduction
This project focuses on 3D scene reconstruction by means of clasis photogrametry principles using MATLAB. To generate the poincloud 2 aproaches will be done:
* With the help of visual odometry the camera pose and orientation will be computed in every step to reconstruct the scene from diferent vews and reconstruct a general poincloud.
* Generating separated poinclouds without odometry and fusing them with the Iterative Closest Point (ICP) algorithm.
![alt text](https://github.com/VictorEscribano/Computer-Vision-Project/blob/main/Introduction_report/Report%20images/camera_support.jpeg | width=100)

## Documentation
Documentation of this project can be found on:
* [Project_resume.pdf](https://github.com/VictorEscribano/Computer-Vision-Project/blob/main/Introduction_report/CV_Short_Project_Resume_Victor_Escribano_Oriol_Contreras.pdf)

## References
* [Monocular_odometry](https://es.mathworks.com/help/vision/ug/monocular-visual-odometry.html)
* [3D_Point_Cloud_Registration](https://es.mathworks.com/help/vision/ug/3-d-point-cloud-registration-and-stitching.html)
* [estgeotform3d](https://es.mathworks.com/help/vision/ref/estgeotform3d.html)
