function ret = equalizeHist(hist, histSum)
[row, col] = size(hist);
ret = zeros(row);

for r = 1:row
    ret(r) = round(histSum(r) * (256 / histSum(row)));
end
end