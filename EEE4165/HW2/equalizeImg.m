function ret = equalizeImg(img)

hist = getHist(img);
% stem(hist, "marker", "none");

histSum = getHistSum(hist);
equlizedHist = equalizeHist(hist, histSum);

[row, col] = size(img);
ret = zeros(row, col);
for r = 1:row
    for c = 1:col
        ret(r, c) = equlizedHist(img(r, c));
    end
end

% hist = getHist(ret);
% stem(hist, "marker", "none");

end