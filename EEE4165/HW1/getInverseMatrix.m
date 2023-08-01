function retMat = getInverseMatrix(originalMatrix)
[r, c] = size(originalMatrix);
identityMatrix = zeros(r, c);

for i = 1:r
    for j = 1:c
        if (i == j)
            identityMatrix(i, j) = 1;
        end
    end
end

AI = [originalMatrix identityMatrix];
for i = 1:r
    [~, k] = max(abs(AI(i:r,i)));
    k = k + i - 1;

    temp = AI(i,:);
    AI(i,:) = AI(k,:);
    AI(k,:) = temp;

    pivot = AI(i,i);
    AI(i,:) = AI(i,:) / pivot;

    for j = i+1:r
        factor = AI(j,i) / AI(i,i);
        AI(j,:) = AI(j,:) - factor * AI(i,:);
    end
end

for i = r:-1:2
    for j = i-1:-1:1
        factor = AI(j,i) / AI(i,i);
        AI(j,:) = AI(j,:) - factor * AI(i,:);
    end
end

A_inv = AI(:,r+1:end);
retMat = A_inv;

% disp(A_inv);
% disp(inv(A));
% disp("-----------------");

end