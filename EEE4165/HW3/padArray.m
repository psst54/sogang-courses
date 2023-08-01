function ret = padArray(img, targetRow, targetCol)
    [row, col] = size(img);
    ret = zeros(targetRow, targetCol);

    for r = 1:row
        for c = 1:col
            ret(r, c) = img(r, c);
        end
    end
end