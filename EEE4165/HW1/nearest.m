function retValue = nearest(img, maxRow, maxCol, ch, targetR, targetC)
retValue = 0;
targetR = round(targetR);
targetC = round(targetC);

if (1 <= targetR && targetR <= maxRow && 1 <= targetC && targetC <= maxCol)
    retValue = img(targetR, targetC, ch);
end
end