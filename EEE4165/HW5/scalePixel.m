function ret = scalePixel(img)
    ret = img;
    [row, col] = size(img);

    minValue = img(1, 1);
    maxValue = img(1, 1);

    for r = 1:row
        for c = 1:col
            minValue = min(minValue, img(r, c));
            maxValue = max(maxValue, img(r, c));
        end
    end

    factor = maxValue - minValue;
    if (factor == 0)
        factor = 1;
    end

    for r = 1:row
        for c = 1:col
            ret(r, c) = (img(r, c) - minValue) / factor * 255;
        end
    end
    
    ret = uint8(ret);
end