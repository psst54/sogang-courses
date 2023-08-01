function retValue = bicubic(img, maxRow, maxCol, ch, targetR, targetC)
retValue = 0;

baseRow = floor(targetR) - 1;
baseCol = floor(targetC) - 1;
pixelValue=[];

pixelValue(1, 1) = getPixel(img, maxRow, baseRow + 0, maxCol, baseCol + 0, ch);
pixelValue(2, 1) = getPixel(img, maxRow, baseRow + 1, maxCol, baseCol + 0, ch);
pixelValue(3, 1) = getPixel(img, maxRow, baseRow + 2, maxCol, baseCol + 0, ch);
pixelValue(4, 1) = getPixel(img, maxRow, baseRow + 3, maxCol, baseCol + 0, ch);

pixelValue(1, 2) = getPixel(img, maxRow, baseRow + 0, maxCol, baseCol + 1, ch);
pixelValue(2, 2) = getPixel(img, maxRow, baseRow + 1, maxCol, baseCol + 1, ch);
pixelValue(3, 2) = getPixel(img, maxRow, baseRow + 2, maxCol, baseCol + 1, ch);
pixelValue(4, 2) = getPixel(img, maxRow, baseRow + 3, maxCol, baseCol + 1, ch);

pixelValue(1, 3) = getPixel(img, maxRow, baseRow + 0, maxCol, baseCol + 2, ch);
pixelValue(2, 3) = getPixel(img, maxRow, baseRow + 1, maxCol, baseCol + 2, ch);
pixelValue(3, 3) = getPixel(img, maxRow, baseRow + 2, maxCol, baseCol + 2, ch);
pixelValue(4, 3) = getPixel(img, maxRow, baseRow + 3, maxCol, baseCol + 2, ch);

pixelValue(1, 4) = getPixel(img, maxRow, baseRow + 0, maxCol, baseCol + 3, ch);
pixelValue(2, 4) = getPixel(img, maxRow, baseRow + 1, maxCol, baseCol + 3, ch);
pixelValue(3, 4) = getPixel(img, maxRow, baseRow + 2, maxCol, baseCol + 3, ch);
pixelValue(4, 4) = getPixel(img, maxRow, baseRow + 3, maxCol, baseCol + 3, ch);
matt = [(baseRow + 0) ^ 3, (baseRow + 0) ^ 2, (baseRow + 0), 1;
    (baseRow + 1) ^ 3, (baseRow + 1) ^ 2, (baseRow + 1), 1;
    (baseRow + 2) ^ 3, (baseRow + 2) ^ 2, (baseRow + 2), 1;
    (baseRow + 3) ^ 3, (baseRow + 3) ^ 2, (baseRow + 3), 1];
matt = getInverseMatrix(matt);

target = [pixelValue(1, 1); pixelValue(2, 1); pixelValue(3, 1); pixelValue(4, 1)];
ans1 = matt * target;
y1 = targetR ^ 3 * ans1(1) + targetR ^ 2 * ans1(2) + targetR * ans1(3) + ans1(4);

target = [pixelValue(1, 2); pixelValue(2, 2); pixelValue(3, 2); pixelValue(4, 2)];
ans2 = matt * target;
y2 = targetR ^ 3 * ans2(1) + targetR ^ 2 * ans2(2) + targetR * ans2(3) + ans2(4);

target = [pixelValue(1, 3); pixelValue(2, 3); pixelValue(3, 3); pixelValue(4, 3)];
ans3 = matt * target;
y3 = targetR ^ 3 * ans3(1) + targetR ^ 2 * ans3(2) + targetR * ans3(3) + ans3(4);

target = [pixelValue(1, 4); pixelValue(2, 4); pixelValue(3, 4); pixelValue(4, 4)];
ans4 = matt * target;
y4 = targetR ^ 3 * ans4(1) + targetR ^ 2 * ans4(2) + targetR * ans4(3) + ans4(4);

matt = [baseCol + 0 ^ 3, baseCol + 0 ^ 2, baseCol + 0, 1;
    (baseCol + 1) ^ 3, (baseCol + 1) ^ 2, (baseCol + 1), 1;
    (baseCol + 2) ^ 3, (baseCol + 2) ^ 2, (baseCol + 2), 1;
    baseCol + 3 ^ 3, baseCol + 3 ^ 2, baseCol + 3, 1];
matt = getInverseMatrix(matt);

target = [y1; y2; y3; y4];
ans5 = matt * target;
final = targetC ^ 3 * ans5(1) + targetC ^ 2 * ans5(2) + targetC * ans5(3) + ans5(4);
if (final < 0)
    final = 0;
end
if (final > 255)
    final = 255;
end
retValue = round(final);
end