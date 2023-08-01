function ret = applyContraharmonicFilter(img, Q)
    [row, col, ~] = size(img);
    ret = zeros(row, col);

    filterSize = 3;
    
    for r = 1:row
        for c = 1:col
            sum1 = 0;
            sum2 = 0;

            for fr = 1:filterSize
                for fc = 1:filterSize
                    targetR = r - int32(filterSize / 2) + fr;
                    targetC = c - int32(filterSize / 2) + fc;

                    if 1 <= targetR && targetR <= row && 1 <= targetC && targetC <= col
                        targetPixel = img(targetR, targetC);
                    else
                        targetPixel = 0;
                    end

                    sum1 = sum1 + targetPixel ^ (Q + 1);
                    sum2 = sum2 + targetPixel ^ Q;
                end
            end

            ret(r, c) = sum1 / sum2;
        end
    end
end