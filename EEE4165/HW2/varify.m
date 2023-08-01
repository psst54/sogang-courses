function ret = varify(img)
[imgRow, imgCol] = size(img);
ret = img;

for ir = 1:imgRow
    for ic = 1:imgCol
        if (ret(ir, ic) > 255)
            ret(ir, ic) = 255;
        elseif( ret(ir, ic) < 0)
            ret(ir, ic) = 0;
        end
    end
end