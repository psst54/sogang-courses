function ret = Translate(img, tc, tr, method)
[row, col, channel] = size(img);

newRow = max(row, ceil(row + abs(tr)));
newCol = max(col, ceil(col + abs(tc)));

ret = zeros(newRow, newCol, channel);

affineMatrix = [1 0 min(-tr, 0); 0 1 min(-tc, 0); 0 0 1];

for r = 1:newRow
    for c = 1:newCol
        for ch = 1:channel
            translatedCoords = affineMatrix * [r; c; 1];

            if (method == "nearest")
                ret(r, c, ch) = nearest(img, row, col, ch, translatedCoords(1), translatedCoords(2));
            end

            if (method == "bicubic")
                ret(r, c, ch) = bicubic(img, row, col, ch, translatedCoords(1), translatedCoords(2));
            end
        end
    end
end
end