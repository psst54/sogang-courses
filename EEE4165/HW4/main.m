clear; clc; close all; warning off;

%% ---------- 1

img_building = imread('images/circuitboard.jpg');

%--------------------------------------------------------

Q = [1.5, 0, -1.5];
M = [7, 15];
AM = [7, 15];

mkdir implementation1

%--------------------------------------------------------

ps = [0.1, 0.3, 0.5];
for psIdx = 1:length(ps)
    title = 'implementation1/salt%0.1f.png';
    title = sprintf(title, ps(psIdx));
    noiseImage = addSaltNoise(img_building, ps(psIdx));
    imwrite(uint8(noiseImage), title);

    for qIdx = 1:length(Q)
        title = 'implementation1/salt%0.1f_contraharmonic%0.1f.png';
        title = sprintf(title, ps(psIdx), Q(qIdx));
        contraharmonic = applyContraharmonicFilter(noiseImage, Q(qIdx));
        imwrite(uint8(contraharmonic), title);
    end

    for mIdx = 1:length(M)
        title = 'implementation1/salt%0.1f_median%d.png';
        title = sprintf(title, ps(psIdx), M(mIdx));
        median = applyMedianFilter(noiseImage, M(mIdx));
        imwrite(uint8(median), title);
    end

    for amIdx = 1:length(AM)
        title = 'implementation1/salt%0.1f_adaptiveMedian%d.png';
        title = sprintf(title, ps(psIdx), AM(amIdx));
        median = applyAdaptiveMedianFilter(noiseImage, AM(amIdx));
        imwrite(uint8(median), title);
    end
end

%--------------------------------------------------------

pp = [0.1, 0.3, 0.5];
for ppIdx = 1:length(pp)
    title = 'implementation1/pepper%0.1f.png';
    title = sprintf(title, pp(ppIdx));
    noiseImage = addPepperNoise(img_building, pp(ppIdx));
    imwrite(uint8(noiseImage), title);

    for qIdx = 1:length(Q)
        title = 'implementation1/pepper%0.1f_contraharmonic%0.1f.png';
        title = sprintf(title, pp(ppIdx), Q(qIdx));
        contraharmonic = applyContraharmonicFilter(noiseImage, Q(qIdx));
        imwrite(uint8(contraharmonic), title);
    end

    for mIdx = 1:length(M)
        title = 'implementation1/pepper%0.1f_median%d.png';
        title = sprintf(title, pp(ppIdx), M(mIdx));
        median = applyMedianFilter(noiseImage, M(mIdx));
        imwrite(uint8(median), title);
    end

    for amIdx = 1:length(AM)
        title = 'implementation1/pepper%0.1f_adaptiveMedian%d.png';
        title = sprintf(title, pp(ppIdx), AM(amIdx));
        median = applyAdaptiveMedianFilter(noiseImage, AM(amIdx));
        imwrite(uint8(median), title);
    end
end

%--------------------------------------------------------

p = [0.1, 0.3];
for pIdx = 1:length(p)
    title = 'implementation1/saltPepper%0.1f.png';
    title = sprintf(title, p(pIdx));
    noiseImage = addPepperNoise(img_building, p(pIdx));
    noiseImage = addSaltNoise(noiseImage, p(pIdx));
    imwrite(uint8(noiseImage), title);

    for qIdx = 1:length(Q)
        title = 'implementation1/saltPepper%0.1f_contraharmonic%0.1f.png';
        title = sprintf(title, p(pIdx), Q(qIdx));
        contraharmonic = applyContraharmonicFilter(noiseImage, Q(qIdx));
        imwrite(uint8(contraharmonic), title);
    end

    for mIdx = 1:length(M)
        title = 'implementation1/saltPepper%0.1f_median%d.png';
        title = sprintf(title, p(pIdx), M(mIdx));
        median = applyMedianFilter(noiseImage, M(mIdx));
        imwrite(uint8(median), title);
    end

    for amIdx = 1:length(AM)
        title = 'implementation1/saltPepper%0.1f_adaptiveMedian%d.png';
        title = sprintf(title, p(pIdx), AM(amIdx));
        median = applyAdaptiveMedianFilter(noiseImage, AM(amIdx));
        imwrite(uint8(median), title);
    end
end

%% ---------- 2

mkdir implementation2
files = ["building", "Chronometer"];

for fileIdx = 1:length(files)
    title = "images/%s.tif";
    title = sprintf(title, files(fileIdx));

    img = imread(title);
    noiseImage = addPeriodicNoise(img, fileIdx);

    title = "implementation2/%s_noise.png";
    title = sprintf(title, files(fileIdx));
    imwrite(uint8(noiseImage), title);

    fourierTransform = fft2(noiseImage);
    shiftedSpectrum = fftshift(fourierTransform);
    magnitudeSpectrum = log(1 + abs(shiftedSpectrum));
    fourierTransformScaled = scalePixel(magnitudeSpectrum);

    title = "implementation2/%s_fourier_scaled.png";
    title = sprintf(title, files(fileIdx));
    imwrite(uint8(fourierTransformScaled), title);

    [row, col, ~] = size(fourierTransform);
    notchFilter = ones(row, col);
    notchFilterRev = zeros(row, col);
    for r = 1:row
        for c = 1:col
            if (432 <= r && r <= 436) ...
                    || (566 <= r && r <= 570) ...
                    || (432 <= c && c <= 436) ...
                    || (566 <= c && c <= 570)
                notchFilter(r, c) = 0;
                notchFilterRev(r, c) = 1;
            end

            switch fileIdx
                case 1
                    dist1 = abs(r - 434) + abs(c - 568);
                    dist2 = abs(r - 568) + abs(c - 434);
                case 2
                    dist1 = abs(r - 434) + abs(c - 434);
                    dist2 = abs(r - 568) + abs(c - 568);
            end

            if dist1 <= 10 || dist2 <= 10
                notchFilter(r, c) = 0;
                notchFilterRev(r, c) = 1;
            end
        end
    end

    fourierTransformFiltered = shiftedSpectrum .* notchFilter;
    shiftedResult = ifftshift(fourierTransformFiltered);
    filteredResult = ifft2(shiftedResult);

    fourierTransformFilteredRev = shiftedSpectrum .* notchFilterRev;
    shiftedResultRev = ifftshift(fourierTransformFilteredRev);
    filteredResultRev = ifft2(shiftedResultRev);

    title = "implementation2/%s_result.png";
    title = sprintf(title, files(fileIdx));
    imwrite(uint8(filteredResult), title);

    title = "implementation2/%s_result_rev.png";
    title = sprintf(title, files(fileIdx));
    imwrite(uint8(filteredResultRev), title);

    magnitudeSpectrum = log(1 + abs(fourierTransformFiltered));
    fourierTransformScaled = scalePixel(magnitudeSpectrum);

    title = "implementation2/%s_fft_image_filtered.png";
    title = sprintf(title, files(fileIdx));
    imwrite(uint8(fourierTransformScaled), title);

    magnitudeSpectrum = log(1 + abs(fourierTransformFilteredRev));
    fourierTransformScaled = scalePixel(magnitudeSpectrum);

    title = "implementation2/%s_fft_image_filtered_rev.png";
    title = sprintf(title, files(fileIdx));
    imwrite(uint8(fourierTransformScaled), title);
end

%% ---------- 3

mkdir implementation3
k = 0.0025;

img = imread('images/test_pattern.tif');
fourierTransform = fft2(img);
shiftedSpectrum = fftshift(fourierTransform);

[M, N] = size(shiftedSpectrum);
[u, v] = meshgrid(1:N, 1:M);
u = u - floor(N/2) - 1;
v = v - floor(M/2) - 1;

turbulence = exp(-k * (u.^2 + v.^2).^(5/6));

fftDegraded = shiftedSpectrum .* turbulence;

shiftedResult = ifftshift(fftDegraded);
filteredResult = ifft2(shiftedResult);
filteredResult = real(filteredResult);

title = "implementation3/turbulence.png";
imwrite(uint8(filteredResult), title);

fourierTransform = fft2(filteredResult);
shiftedSpectrum = fftshift(fourierTransform);

K = 0.00000001;
while K < 0.1
    K = K * 10;
    result = (1 ./ turbulence) .* ((abs(turbulence) .^ 2) ./ (abs(turbulence) .^ 2 + K)) .* shiftedSpectrum;
    shiftedResult = ifftshift(result);
    filteredResult = ifft2(shiftedResult);
    filteredResult = real(filteredResult);

    title = "implementation3/%0.7f.png";
    title = sprintf(title, K);
    imwrite(uint8(filteredResult), title);
end

result = (1 ./ turbulence) .* ((abs(turbulence) .^ 2) ./ (abs(turbulence) .^ 2)) .* shiftedSpectrum;
shiftedResult = ifftshift(result);
filteredResult = ifft2(shiftedResult);
filteredResult = real(filteredResult);

title = "implementation3/0.png";
title = sprintf(title);
imwrite(uint8(filteredResult), title);

%% ---------- additional1

img_building = imread('images/circuitboard.jpg');

%--------------------------------------------------------

M = [3, 5, 11, 15];

mkdir additional1

%--------------------------------------------------------

ps = [0.3];
for psIdx = 1:length(ps)
    title = 'additional1/salt%0.1f.png';
    title = sprintf(title, ps(psIdx));
    noiseImage = addSaltNoise(img_building, ps(psIdx));
    imwrite(uint8(noiseImage), title);

    for mIdx = 1:length(M)
        title = 'additional1/salt%0.1f_median%d.png';
        title = sprintf(title, ps(psIdx), M(mIdx));

        if M(mIdx) <= 5
            median = applyMedianFilter(noiseImage, M(mIdx));
            median = applyMedianFilter(median, M(mIdx));
            median = applyMedianFilter(median, M(mIdx));
        else

            median = applyMedianFilter(noiseImage, M(mIdx));
        end

        imwrite(uint8(median), title);
    end
end

%--------------------------------------------------------

pp = [0.3];
for ppIdx = 1:length(pp)
    title = 'additional1/pepper%0.1f.png';
    title = sprintf(title, pp(ppIdx));
    noiseImage = addPepperNoise(img_building, pp(ppIdx));
    imwrite(uint8(noiseImage), title);

    for mIdx = 1:length(M)
        title = 'additional1/pepper%0.1f_median%d.png';
        title = sprintf(title, pp(ppIdx), M(mIdx));

        if M(mIdx) <= 5
            median = applyMedianFilter(noiseImage, M(mIdx));
            median = applyMedianFilter(median, M(mIdx));
            median = applyMedianFilter(median, M(mIdx));
        else

            median = applyMedianFilter(noiseImage, M(mIdx));
        end

        imwrite(uint8(median), title);
    end
end

%--------------------------------------------------------

p = [0.3];
for pIdx = 1:length(p)
    title = 'additional1/saltPepper%0.1f.png';
    title = sprintf(title, p(pIdx));
    noiseImage = addPepperNoise(img_building, p(pIdx));
    noiseImage = addSaltNoise(noiseImage, p(pIdx));
    imwrite(uint8(noiseImage), title);

    for mIdx = 1:length(M)
        title = 'additional1/saltPepper%0.1f_median%d.png';
        title = sprintf(title, p(pIdx), M(mIdx));

        if M(mIdx) <= 5
            median = applyMedianFilter(noiseImage, M(mIdx));
            median = applyMedianFilter(median, M(mIdx));
            median = applyMedianFilter(median, M(mIdx));
        else

            median = applyMedianFilter(noiseImage, M(mIdx));
        end

        imwrite(uint8(median), title);
    end
end

%% ---------- additional2

mkdir additional2
files = ["building", "Chronometer"];

for fileIdx = 1:length(files)
    title = "images/%s.tif";
    title = sprintf(title, files(fileIdx));

    img = imread(title);

    fourierTransform = fft2(img);
    shiftedSpectrum = fftshift(fourierTransform);
    magnitudeSpectrum = log(1 + abs(shiftedSpectrum));
    fourierTransformScaled = scalePixel(magnitudeSpectrum);

    title = "additional2/%s_original_fourier_scaled.png";
    title = sprintf(title, files(fileIdx));
    imwrite(uint8(fourierTransformScaled), title);

    noiseImage = addPeriodicNoise(img, fileIdx + 2);

    title = "additional2/%s_noise.png";
    title = sprintf(title, files(fileIdx));
    imwrite(uint8(noiseImage), title);

    fourierTransform = fft2(noiseImage);
    shiftedSpectrum = fftshift(fourierTransform);
    magnitudeSpectrum = log(1 + abs(shiftedSpectrum));
    fourierTransformScaled = scalePixel(magnitudeSpectrum);

    title = "additional2/%s_fourier_scaled.png";
    title = sprintf(title, files(fileIdx));
    imwrite(uint8(fourierTransformScaled), title);

    [row, col, ~] = size(fourierTransform);
    notchFilter = ones(row, col);
    notchFilterRev = zeros(row, col);
    for r = 1:row
        for c = 1:col
            switch fileIdx
                case 1
                    dist1 = abs(r - 501) + abs(c - 568);
                    dist2 = abs(r - 501) + abs(c - 434);
                case 2
                    dist1 = abs(r - 568) + abs(c - 501);
                    dist2 = abs(r - 434) + abs(c - 501);
            end

            if dist1 <= 10 || dist2 <= 10
                notchFilter(r, c) = 0;
                notchFilterRev(r, c) = 1;
            end
        end
    end

    fourierTransformFiltered = shiftedSpectrum .* notchFilter;
    shiftedResult = ifftshift(fourierTransformFiltered);
    filteredResult = ifft2(shiftedResult);

    fourierTransformFilteredRev = shiftedSpectrum .* notchFilterRev;
    shiftedResultRev = ifftshift(fourierTransformFilteredRev);
    filteredResultRev = ifft2(shiftedResultRev);

    title = "additional2/%s_result.png";
    title = sprintf(title, files(fileIdx));
    imwrite(uint8(filteredResult), title);

    title = "additional2/%s_result_rev.png";
    title = sprintf(title, files(fileIdx));
    imwrite(uint8(filteredResultRev), title);

    magnitudeSpectrum = log(1 + abs(fourierTransformFiltered));
    fourierTransformScaled = scalePixel(magnitudeSpectrum);

    title = "additional2/%s_fft_image_filtered.png";
    title = sprintf(title, files(fileIdx));
    imwrite(uint8(fourierTransformScaled), title);

    magnitudeSpectrum = log(1 + abs(fourierTransformFilteredRev));
    fourierTransformScaled = scalePixel(magnitudeSpectrum);

    title = "additional2/%s_fft_image_filtered_rev.png";
    title = sprintf(title, files(fileIdx));
    imwrite(uint8(fourierTransformScaled), title);
end

%% ---------- additional3

k = 0.0025;

img = imread('images/test_pattern.tif');
fourierTransform = fft2(img);
shiftedSpectrum = fftshift(fourierTransform);

[M, N] = size(shiftedSpectrum);
[u, v] = meshgrid(1:N, 1:M);
u = u - floor(N/2) - 1;
v = v - floor(M/2) - 1;

turbulence = exp(-k * (u.^2 + v.^2).^(5/6));

fftDegraded = shiftedSpectrum .* turbulence;

shiftedResult = ifftshift(fftDegraded);
filteredResult = ifft2(shiftedResult);
filteredResult = real(filteredResult);

fourierTransform = fft2(filteredResult);
shiftedSpectrum = fftshift(fourierTransform);

K = 0.00000000001;
while K < 0.1
    K = K * 10;
    result = (1 ./ turbulence) .* ((abs(turbulence) .^ 2) ./ (abs(turbulence) .^ 2 + K)) .* shiftedSpectrum;
    shiftedResult = ifftshift(result);
    filteredResult = ifft2(shiftedResult);
    filteredResult = real(filteredResult);

    ret = calcPSNR(img, filteredResult);
    fprintf("%0.10f : %0.4f\n", K, ret);
end