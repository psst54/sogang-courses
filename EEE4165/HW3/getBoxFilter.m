function ret = getBoxFilter(size)
ret = zeros(size, size);
for r = 1:size
    for c = 1:size
        ret(r, c) = 1 / (size * size);
    end
end
end