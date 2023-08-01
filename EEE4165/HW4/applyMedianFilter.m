function ret = applyMedianFilter(img, filterSize)
    [row, col, ~] = size(img);
    ret = zeros(row, col);
    
    for r = 1:row
        for c = 1:col
            arr = zeros(1, filterSize ^ 2);

            for fr = 1:filterSize
                for fc = 1:filterSize
                    targetR = r - int32(filterSize / 2) + fr;
                    targetC = c - int32(filterSize / 2) + fc;

                    if 1 <= targetR && targetR <= row && 1 <= targetC && targetC <= col
                        targetPixel = img(targetR, targetC);
                    else
                        targetPixel = 0;
                    end

                    arr(1, (fr - 1) * filterSize + fc) = targetPixel;
                end
            end

            ret(r, c) = median(arr);
        end
    end

end