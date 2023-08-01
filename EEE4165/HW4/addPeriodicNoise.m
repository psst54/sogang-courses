function ret = addPeriodicNoise(img, mode)
[row, col, ~] = size(img);
[X, Y] = meshgrid(1:col, 1:row);

period = 15;
amplitude = 100;
switch mode
    case 1
        noisePattern  = amplitude * cos(-2 * pi * X / period + 2 * pi * Y / period);
    case 2
        noisePattern  = amplitude * cos(2 * pi * X / period + 2 * pi * Y / period);
    case 3
        noisePattern  = amplitude * cos(2 * pi * X / period);
    case 4
        noisePattern  = amplitude * cos(2 * pi * Y / period);
end

ret = double(img) + noisePattern;

% figure("Name", "shifted_spectrum_building");
% imshow(uint8(ret));
end