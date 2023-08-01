function ret = conv_2D(img, kernel)
[imgRow, imgCol] = size(img);
[kerRow, kerCol] = size(kernel);
ret = zeros(imgRow, imgCol);

% 원본 이미지의 모든 픽셀에 대하여 컨볼루션 작업을 수행한다.
for ir = 1:imgRow
    for ic = 1:imgCol
        ret(ir, ic) = 0;

        % 한 픽셀에 대하여 커널의 모든 값을 곱한다.
        for kr = 1:kerRow
            for kc = 1:kerCol
                nexR = ir - kr + floor(kerRow / 2) + 1;
                nexC = ic - kc + floor(kerCol / 2) + 1;

                % 현재 픽셀 인덱스가 이미지 범위 안인 경우 해당 픽셀을 참조한다.
                if (1 <= nexR && nexR <= imgRow &&...
                        1 <= nexC && nexC <= imgCol)
                    currentPixel = img(nexR, nexC);
                else
                    % 이미지 바깥에 있는 경우 zero padding을 수행한다.
                    currentPixel = 0;
                end

                ret(ir, ic) = ret(ir, ic) + double(currentPixel) * kernel(kr, kc);
            end
        end
    end
end

end