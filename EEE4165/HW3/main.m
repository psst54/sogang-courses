clear; clc; close all; warning off;

%% ---------- 1

% ------------------------------------------------------------

img_building = imread('images/building.tif');
img_chronometer = imread('images/Chronometer.tif');

fourier_transform_building = fft2(img_building);
shifted_spectrum_building = fftshift(fourier_transform_building);
magnitude_spectrum_building = log(1 + abs(shifted_spectrum_building));
fourier_transform_building_scaled = scalePixel(magnitude_spectrum_building);
% figure("Name", "shifted_spectrum_building");
% imshow(fourier_transform_building_scaled);
imwrite(fourier_transform_building_scaled, 'result1/fourier_transform_building.png');

phase_spectrum_building = angle(fourier_transform_building);
% figure("Name", "phase_spectrum_building");
% % imshow(phase_spectrum_building);
imwrite(phase_spectrum_building, 'result1/phase_spectrum_building.png');

% ------------------------------------------------------------

fourier_transform_chronometer = fft2(img_chronometer);
shifted_spectrum_chronometer = fftshift(fourier_transform_chronometer);
magnitude_spectrum_chronometer = log(1 + abs(shifted_spectrum_chronometer));
fourier_transform_chronometer_scaled = scalePixel(magnitude_spectrum_chronometer);
% figure("Name", "magnitude_spectrum_chronometer");
% imshow(fourier_transform_chronometer_scaled);
imwrite(fourier_transform_chronometer_scaled, 'result1/fourier_transform_chronometer.png');

phase_spectrum_chronometer = angle(fourier_transform_chronometer);
% figure("Name", "phase_spectrum_chronometer");
% imshow(phase_spectrum_chronometer);
imwrite(phase_spectrum_chronometer, 'result1/phase_spectrum_chronometer.png');

% ------------------------------------------------------------

combined_spectrum = abs(fourier_transform_building) .* exp(1j * phase_spectrum_chronometer);
reconstructed_img = real(ifft2(combined_spectrum));

reconstructed_img = scalePixel(reconstructed_img); 
% figure("Name", "reconstructed_image");
% imshow(reconstructed_image);
imwrite(reconstructed_img, 'result1/reconstructed_img_1.png');

% ------------------------------------------------------------

combined_spectrum = abs(fourier_transform_chronometer) .* exp(1j * phase_spectrum_building);
reconstructed_img = real(ifft2(combined_spectrum));

reconstructed_img = scalePixel(reconstructed_img); 
% figure("Name", "reconstructed_image");
% imshow(reconstructed_image);
imwrite(reconstructed_img, 'result1/reconstructed_img_2.png');

%% ---------- 2
img = imread('images/test_pattern.tif');
pad_size = 1000;

applyBoxFilter(img, pad_size, 5, 2);
applyBoxFilter(img, pad_size, 21, 2);

applyGaussianFilter(img, pad_size, 1, 2);
applyGaussianFilter(img, pad_size, 5, 2);


%% ---------- 3
img = imread('images/test_pattern.tif');
pad_size = 1000;

applyBoxFilter(img, pad_size, 13, 3);
applyBoxFilter(img, pad_size, 25, 3);

applyGaussianFilter(img, pad_size, 4, 3);
applyGaussianFilter(img, pad_size, 8, 3);