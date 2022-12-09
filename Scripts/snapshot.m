clear all;
close all;
clc;

webcamlist
left=webcam(2);
right=webcam();

img=snapshot(left);
img2=snapshot(right);

preview(left);
preview(right);
prompt= 'Take photo?(1/0)';
out=input(prompt);
num = 10;
while out==1
    left_im = snapshot(left);
    right_im = snapshot(right);
    left_name = 'images/Left/left_' + string(num)+'.png';
    right_name = 'images/Right/right_' + string(num)+'.png';
    disp('Saving images...')
    imwrite(left_im, left_name);
    imwrite(right_im, right_name);
    disp('Images saved! There are '+ string(num)+' images saved')
    preview(left);
    preview(right);
    prompt= 'Take photo?(1/0)';
    out=input(prompt);
    num = num + 1;
end
clear left;
clear right;
disp('Closing proogram. There is a total of '+ string(num)+' images saved')
