function ret = addPepperNoise(img, ps)
    [row, col, ch] = size(img);
    ret = zeros(row, col);

    for r = 1:row
        for c = 1:col
            if rand(1,1) <= ps
                ret(r, c) = 0;
            else 
                ret(r, c) = img(r, c);
            end
        end
    end
end