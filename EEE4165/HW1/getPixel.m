function ret = getPixel(img, maxR, tarR, maxC, tarC, channel)
ret = 0;
if (1 <= tarR && tarR <= maxR && 1 <= tarC && tarC <= maxC)
    ret = img(tarR, tarC, channel);
end
end