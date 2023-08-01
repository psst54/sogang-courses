function ret = getHist(img)
ret = zeros(256);
[imgRow, imgCol] = size(img);

for ir = 1:imgRow
    for ic = 1:imgCol
        ret(img(ir, ic)) = ret(img(ir, ic)) + 1;
    end
end
end