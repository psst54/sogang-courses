clear; clc; close all; warning off;

%% ---------- 1

img = double(imread('jupiter.tif'));
[row, col, ch] = size(img);

R = img(:, :, 1);
G = img(:, :, 2);
B = img(:, :, 3);

hSpace = zeros(row, col);
sSpace = zeros(row, col);
iSpace = zeros(row, col);

for r = 1:row
    for c = 1:col
        red = R(r, c);
        green = G(r, c);
        blue = B(r, c);

        % h space-----------------
        theta = (((red - green) + (red - blue)) / 2) / (sqrt((red - green) ^ 2 + (red - blue) * (green - blue)));
        theta = acosd(theta);
        if (blue <= green)
            hSpace(r, c) = theta;
        else
            hSpace(r, c) = 360 - theta;
        end

        % s space-----------------
        sSpace(r, c) = 1 - 3 / (red + green + blue) * min([red, green, blue]);

        % i space-----------------
        iSpace(r, c) = (red + green + blue) / 3;
    end
end

maxS = max(sSpace, [], 'all');

%----------------------------------------------
thres10 = maxS * 0.1;
mask10 = zeros(row, col);

for r = 1:row
    for c = 1:col
        if (sSpace(r, c) >= thres10)
            mask10(r, c) = 1;
        else
            mask10(r, c) = 0;
        end
    end
end

thres10 = 320;
hueMask10 = hSpace .* mask10;

for r = 1:row
    for c = 1:col
        if (hueMask10(r, c) >= thres10)
            hueMask10(r, c) = 1;
        else
            hueMask10(r, c) = 0;
        end
    end
end

result10 = double(img) .* hueMask10;

%----------------------------------------------
thres20 = maxS * 0.2;
mask20 = zeros(row, col);

for r = 1:row
    for c = 1:col
        if (sSpace(r, c) >= thres20)
            mask20(r, c) = 1;
        else
            mask20(r, c) = 0;
        end
    end
end

thres20 = 320;
hueMask20 = hSpace .* mask20;

for r = 1:row
    for c = 1:col
        if (hueMask20(r, c) >= thres20)
            hueMask20(r, c) = 1;
        else
            hueMask20(r, c) = 0;
        end
    end
end

result20 = double(img) .* hueMask20;


mkdir implementation1

% figure();
% imshow(uint8(hSpace));
imwrite(uint8(hSpace), 'implementation1/hSpace.png');

% figure();
% imshow(scalePixel(hSpace));
imwrite(scalePixel(hSpace), 'implementation1/hSpace_scaled.png');

% figure();
% imshow(uint8(sSpace));
imwrite(uint8(sSpace), 'implementation1/sSpace.png');

% figure();
% imshow(scalePixel(sSpace));
imwrite(scalePixel(sSpace), 'implementation1/sSpace_scaled.png');

% figure();
% imshow(uint8(iSpace));
imwrite(uint8(iSpace), 'implementation1/iSpace.png');

% figure();
% imshow(uint8(mask10));
imwrite(uint8(mask10), 'implementation1/mask10.png');

% figure();
% imshow(scalePixel(mask10));
imwrite(scalePixel(mask10), 'implementation1/mask10_scaled.png');

% figure();
% imshow(scalePixel(hueMask10) * 255);
imwrite(scalePixel(hueMask10) * 255, 'implementation1/hueMask10.png');

% figure();
% imshow(uint8(result10));
imwrite(uint8(result10), 'implementation1/result10.png');

% figure();
% imshow(uint8(mask20));
imwrite(uint8(mask20), 'implementation1/mask20.png');

% figure();
% imshow(scalePixel(mask20));
imwrite(scalePixel(mask20), 'implementation1/mask20_scaled.png');

% figure();
% imshow(scalePixel(hueMask20) * 255);
imwrite(scalePixel(hueMask20) * 255, 'implementation1/hueMask20.png');

% figure();
% imshow(uint8(result20));
imwrite(uint8(result20), 'implementation1/result20.png');

%% ---------- 2

img = double(imread('jupiter.tif'));
[row, col, ch] = size(img);
croppedImg = img(233:294, 59:98, :);

R = img(:, :, 1);
G = img(:, :, 2);
B = img(:, :, 3);
RCropped = croppedImg(:, :, 1);
GCropped = croppedImg(:, :, 2);
BCropped = croppedImg(:, :, 3);

stdR = std2(R);
stdG = std2(G);
stdB = std2(B);
stdRCropped = std2(RCropped);
stdGCropped = std2(GCropped);
stdBCropped = std2(BCropped);

disp("std of RGB");
disp(stdR);
disp(stdG);
disp(stdB);
disp("std of RGB of cropped image");
disp(stdRCropped);
disp(stdGCropped);
disp(stdBCropped);

meanR = mean(RCropped,'all');
meanG = mean(GCropped,'all');
meanB = mean(BCropped,'all');

disp("mean of RGB of cropped image");
disp(meanR);
disp(meanG);
disp(meanB);


result1 = img;
result2 = img;

for r = 1:row
    for c = 1:col
        red = img(r, c, 1);
        green = img(r, c, 2);
        blue = img(r, c, 3);

        redOk = meanR - stdR * 1.25 <= red && red <= meanR + stdR * 1.25;
        greenOk = meanG - stdG * 1.25 <= green && green <= meanG + stdG * 1.25;
        blueOk = meanB - stdB * 1.25 <= blue && blue <= meanB + stdB * 1.25;

        if (~(redOk && greenOk && blueOk))
            result1(r, c, 1) = 0;
            result1(r, c, 2) = 0;
            result1(r, c, 3) = 0;
        end
    end
end

for r = 1:row
    for c = 1:col
        red = img(r, c, 1);
        green = img(r, c, 2);
        blue = img(r, c, 3);

        redOk = meanR - stdRCropped * 1.25 <= red && red <= meanR + stdRCropped * 1.25;
        greenOk = meanG - stdGCropped * 1.25 <= green && green <= meanG + stdGCropped * 1.25;
        blueOk = meanB - stdBCropped * 1.25 <= blue && blue <= meanB + stdBCropped * 1.25;

        if (~(redOk && greenOk && blueOk))
            result2(r, c, 1) = 0;
            result2(r, c, 2) = 0;
            result2(r, c, 3) = 0;
        end
    end
end

mkdir implementation2

% figure();
% imshow(uint8(croppedImg));
imwrite(uint8(croppedImg), 'implementation2/croppedImg.png');

% figure();
% imshow(uint8(result1));
imwrite(uint8(result1), 'implementation2/result1.png');

% figure();
% imshow(uint8(result2));
imwrite(uint8(result2), 'implementation2/result2.png');