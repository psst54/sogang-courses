function ret = getHistSum(hist)
len = size(hist);
ret = zeros(len);
for l = 1:len
    if (l > 1)
        ret(l) = hist(l) + ret(l - 1);
    end
end
end