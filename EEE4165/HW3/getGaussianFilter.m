function ret = getGaussianFilter(sigma, size)
    ret = zeros(size, size);
    for r = 1:size
        for c = 1:size
            ret(r, c) = (ceil(size / 2) - r)^2 + (ceil(size / 2) - c)^2;
            ret(r, c) = exp(-ret(r, c) / (2 * sigma^2));
        end
    end

    ret = ret / sum(ret, 'all');
end