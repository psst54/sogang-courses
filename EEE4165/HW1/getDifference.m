function ret = getDifference(img1, img2)
[row1, col1, channel1] = size(img1);
[row2, col2, channel2] = size(img2);
ret = 0;

if (row1 ~= row2)
    disp("row error");
    disp(row1);
    disp(row2);
    ret = 1;
end
if (col1 ~= col2)
    disp("col error");
    disp(col1);
    disp(col2);
    ret = 1;
end
if (channel1 ~= channel2)
    disp("channel error");
    disp(channel1);
    disp(channel2);
    ret = 1;
end

if (ret == 1)
    return;
end

errorSum = int32(0);

for r = 1:row1
    for c = 1:col1
        for ch = 1:channel1
            a = int32(img1(r, c, ch));
            b = int32(img2(r, c, ch));
            diff = int32(abs(a - b));
            errorSum = errorSum + diff;
            if (diff ~= 0)
                disp(diff);
                disp(errorSum);
                disp("------");
            end
        end
    end
end
disp("END!!");
end