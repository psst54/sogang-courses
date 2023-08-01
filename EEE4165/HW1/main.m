clear; clc; close all; warning off;

img = imread('letterT.tif');




% % "nearest" or "bicubic"
% translateMethod = "bicubic";
% rotationMethod = "bicubic";
% tx = -200;
% ty = -100;
% rotateAngle = 30;
% 
% img1 = img;
% img1 = translate(img1, tx, ty, translateMethod);
% img1 = rotate(img1, rotateAngle, rotationMethod);
% 
% img2 = img;
% img2 = imtranslate(img2, [tx, ty],"OutputView", "full");
% img2 = imrotate(img2, rotateAngle, rotationMethod);
% 
% imwrite(uint8(img1), '1.tif');
% imwrite(uint8(img2), '2.tif');
% getDifference(img1, img2);


% "nearest" or "bicubic"
translateMethod = "nearest";
rotationMethod = "nearest";
tx = 20;
ty = 30;
rotateAngle = 30;


a = Translate(img, tx, ty, translateMethod);
imwrite(uint8(a), '1-a.tif');
b = Rotate(img, rotateAngle, rotationMethod);
imwrite(uint8(b), '1-b.tif');

translated_nearest = Translate(img, tx, ty, translateMethod);
rotated_nearest = Rotate(translated_nearest, rotateAngle, rotationMethod);
% imshow(uint8(rotated_nearest))
imwrite(uint8(rotated_nearest), '1-c.tif');


rotated_nearest = Rotate(img, rotateAngle, rotationMethod);
translated_nearest = Translate(rotated_nearest, tx, ty, translateMethod);
% imshow(uint8(translated_nearest))
imwrite(uint8(translated_nearest), '1-d.tif');


translateMethod = "bicubic";
rotationMethod = "bicubic";

translated_nearest = Translate(img, tx, ty, translateMethod);
% imshow(uint8(translated_nearest))
imwrite(uint8(translated_nearest), '2-a.tif');


rotated_nearest = Rotate(img, rotateAngle, rotationMethod);
% imshow(uint8(rotated_nearest))
imwrite(uint8(rotated_nearest), '2-b.tif');
