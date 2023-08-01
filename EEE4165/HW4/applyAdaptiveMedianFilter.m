function ret = applyAdaptiveMedianFilter(img, maxFilterSize)
[row, col, ~] = size(img);
ret = zeros(row, col);

for r = 1:row
    for c = 1:col
        for currentFilterSize = 3:2:maxFilterSize
            arr = zeros(1, currentFilterSize ^ 2);

            for fr = 1:currentFilterSize
                for fc = 1:currentFilterSize
                    targetR = r - int32(currentFilterSize / 2) + fr;
                    targetC = c - int32(currentFilterSize / 2) + fc;

                    if 1 <= targetR && targetR <= row && 1 <= targetC && targetC <= col
                        targetPixel = img(targetR, targetC);
                    else
                        targetPixel = 0;
                    end

                    arr(1, (fr - 1) * currentFilterSize + fc) = targetPixel;
                end
            end

            arr = sort(arr);
            zMin = arr(1, 1);
            zMax = arr(1, end);
            zMed = arr(1, int32(end / 2));
            zXy = img(r, c);

            if zMin < zMed && zMed < zMax
                if zMin < zXy && zXy < zMax
                    ret(r, c) = zXy;
                else
                    ret(r, c) = zMed;
                end
                break;
            else
                if currentFilterSize + 2 <= maxFilterSize
                    continue;
                else
                    ret(r, c) = zMed;
                    break;
                end
            end

        end
    end
end

end