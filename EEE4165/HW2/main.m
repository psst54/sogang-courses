clear; clc; close all; warning off;

%% ---------- box filter
%--------------------------------------------------------------

BOX_FILTER_SIZE = 25;
img = imread('test_pattern.tif');

col_vector = makeBoxFilter(BOX_FILTER_SIZE);
box = conv_2D(img, col_vector);
box = varify(box);

figure("Name", "Box Filter");
imshow(uint8(box));
imwrite(uint8(box), 'box_filtered.tif');

%% ---------- box filter(separable)
%--------------------------------------------------------------

BOX_FILTER_SIZE = 25;
img = imread('test_pattern.tif');

row_vector = zeros(BOX_FILTER_SIZE, 1);
for i = 1:BOX_FILTER_SIZE
    row_vector(i, 1) = 1 / double(BOX_FILTER_SIZE);
end
box = conv_2D(img, row_vector);

col_vector = zeros(1, BOX_FILTER_SIZE);
for i = 1:BOX_FILTER_SIZE
    col_vector(1, i) = 1 / double(BOX_FILTER_SIZE);
end
box = conv_2D(box, col_vector);

box = varify(box);
figure("Name", "Box Filter (separable)");
imshow(uint8(box));
imwrite(uint8(box), 'box_filtered_separable.tif');

%% ---------- sobel filter
%--------------------------------------------------------------

img = imread('contact-lens.tif');

sobel_filter_y = [-1 -2 -1; 0 0 0; 1 2 1];
sobel_y = conv_2D(img, sobel_filter_y);
sobel_y = abs(sobel_y);
imwrite(uint8(varify(sobel_y)), 'contact-lens_sobel_y.tif');

sobel_filter_x = [-1 0 1; -2 0 2; -1 0 1];
sobel_x = conv_2D(img, sobel_filter_x);
sobel_x = abs(sobel_x);
imwrite(uint8(varify(sobel_x)), 'contact-lens_sobel_x.tif');

sobel_final = sobel_y + sobel_x;
sobel_final = varify(sobel_final);
figure("Name", "Sobel Filter");
imshow(uint8(sobel_final));
imwrite(uint8(sobel_final), 'contact-lens_sobel_final.tif');

%% ---------- sobel filter(separable)
%--------------------------------------------------------------

img = imread('contact-lens.tif');
sobel_y = conv_2D(img, [1 2 1]);
sobel_y = conv_2D(sobel_y, [-1; 0; 1]);

sobel_y = abs(sobel_y);
imwrite(uint8(varify(sobel_y)), 'contact-lens_sobel_y_separable.tif');

sobel_x = conv_2D(img, [-1 0 1]);
sobel_x = conv_2D(sobel_x, [1; 2; 1]);

sobel_x = abs(sobel_x);
imwrite(uint8(varify(sobel_x)), 'contact-lens_sobel_x_separable.tif');

sobel_final = sobel_y + sobel_x;
sobel_final = varify(sobel_final);
figure("Name", "Sobel Filter (separable)");
imshow(uint8(sobel_final));
imwrite(uint8(sobel_final), 'contact-lens_sobel_final_separable.tif');

%% ---------- histogram equalization
%--------------------------------------------------------------

img = imread('pollen1.tif');
equalized_img = equalizeImg(img);
figure("Name", "pollen1_equalized");
imshow(uint8(equalized_img));
imwrite(uint8(equalized_img), 'pollen1_equalized.tif');

img = imread('pollen2.tif');
equalized_img = equalizeImg(img);
figure("Name", "pollen2_equalized");
imshow(uint8(equalized_img));
imwrite(uint8(equalized_img), 'pollen2_equalized.tif');