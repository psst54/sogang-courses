function ret = Rotate(img, deg, method)
deg = deg * -1;
[row, col, channel] = size(img);

newRow = ceil(row * abs(cosd(deg)) + col * abs(sind(deg)));
newCol = ceil(row * abs(sind(deg)) + col * abs(cosd(deg)));

ret = zeros(newRow, newCol, channel);

rotateMatrix = [cosd(deg) -sind(deg) 0; sind(deg) cosd(deg) 0; 0 0 1];
translateMatrix = [1 0 row / 2; 0 1 col / 2; 0 0 1];
translateMatrix2 = [1 0 -newRow / 2; 0 1 -newCol / 2; 0 0 1];
affineMatrix = translateMatrix * rotateMatrix * translateMatrix2;

for r = 1:newRow
    for c = 1:newCol
        for ch = 1:channel
            rotatedCoords = affineMatrix * [r; c; 1];

            if (method == "nearest")
                ret(r, c, ch) = nearest(img, row, col, ch, rotatedCoords(1), rotatedCoords(2));
            end

            if (method == "bicubic")
                ret(r, c, ch) = bicubic(img, row, col, ch, rotatedCoords(1), rotatedCoords(2));
            end
        end
    end
end
end