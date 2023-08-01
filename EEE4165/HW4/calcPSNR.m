function ret = calcPSNR(imgA, imgB)
    imgA = double(imgA);
    maxA = max(imgA(:));
    maxB = max(imgB(:));

    max_pixel_value = max(maxA, maxB);

    mse = mean((imgA(:) - imgB(:)) .^ 2);
    ret = 10 * log10((max_pixel_value ^ 2) / mse);
end