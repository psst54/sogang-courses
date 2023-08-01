img = imread('Test.tif');
[m, n, c] = size(img);
for i = 1:m
    img(i, 20) = 255;
end
imshow(img)
imwrite(img, 'Save.tif');