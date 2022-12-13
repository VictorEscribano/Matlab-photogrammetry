# 3D Reconstruction from stereo images

## Requirements
* Computer vision toolbox
* Webcam toolbox
* Matlab 2022b (recomended)

## Introduction
This project focuses on 3D scene reconstruction by means of clasis photogrametry principles using MATLAB. To generate the poincloud the following steps will be done:

* Design a support for the stereo cameras to ensure the same external parameters in all images.
<p align="center">
  <img src="https://github.com/VictorEscribano/Computer-Vision-Project/blob/main/resources/Support/Camera%20support.jpeg" width="240">
</p>
* Stereo camera calibration to extract the intrinsic parameters of both sensors and the position of the right camera relative to the left (main) one.
<p align="center">
  <img src="https://github.com/VictorEscribano/Computer-Vision-Project/blob/main/resources/habitacion_reconstruction/Extrinsic_params.png" width="240">
</p>
* Obtain a set of consecutive images of the environment to recostruct.
<p align="center">
  <img src="https://github.com/VictorEscribano/Computer-Vision-Project/blob/main/resources/habitacion_reconstruction/views_sequence.png" width="480">
</p>
* Use Structure from Motion (Visual odometry) to estimate the actual position of the left camera with respect to the previous frame, and with the extrinsic parameters estimate also the right camera position relative to the new left camera transformation.
<p align="center">
  <img src="https://github.com/VictorEscribano/Computer-Vision-Project/blob/main/resources/habitacion_reconstruction/camera_poses.png" width="480">
</p>
* Extract a 3D poincloud by means of triangulation for every camera pose.
<p align="center">
  
</p>
* Fusion those pointclouds with different orientations using Iterative Closest Point (ICP) algorithm.
<p align="center">
  <img src="https://github.com/VictorEscribano/Computer-Vision-Project/blob/main/resources/habitacion_reconstruction/multiview_reconstruction.png" width="480">
</p>
* (Extra) Extract 3D known shapes from the computed poincloud (spheres, cones, etc.)

## Main issues
* When obtaining the stereo pair images at freehand some error due to hand tremoring can be induced, affecting the computation of the disparity map. As we know when displaying the red-cyan anaglyph from the stereo pair images, the colser objects have bigger disparity and the ones that are futher away have less disparity between pixels. This and tremor affcts more to the objects that are colser to the cameras on the scene.

To solve this a base for the cameras have been designed in order toavoid this hand tremoring. Better solutions can be implemented such as synchronize the shutter of the cameras, some cameras can accept software triggering or some PWM hardware triggering to capture the images with the same timestamp, in this report this approach will not be used.

* Photogrametry algorithms like this one does not hanle reflections, this is because the features of one image does not correspond with the ones on the other one, causing problems on reconstructing reflecting surfaces.

To solve this I personally recomend the use of more complex tools like NeRF (Neural Radial Fields), this neural networks can make very dense and light responive reconstructions.

## Documentation
Documentation of this project can be found on:
* [Project_resume.pdf](https://github.com/VictorEscribano/Computer-Vision-Project/blob/main/Introduction_report/CV_Short_Project_Resume_Victor_Escribano_Oriol_Contreras.pdf)

## References
* [Monocular odometry](https://es.mathworks.com/help/vision/ug/monocular-visual-odometry.html)
* [3D PointCloud Registration](https://es.mathworks.com/help/vision/ug/3-d-point-cloud-registration-and-stitching.html)
* [estgeotform3d](https://es.mathworks.com/help/vision/ref/estgeotform3d.html)
* [Structure from motion](https://es.mathworks.com/help/vision/ug/structure-from-motion-from-multiple-views.html)
