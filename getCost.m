function [cost] = getCost(C, X, Y)
%COST Calculates the cost of a truss

[numJoints,~] = size(C);
rows = numJoints;
totalLength = 0;

for i = 1:rows
    indices = find(C(:,i));
    v1 = indices(1);
    v2 = indices(2);


    dx = X(v1) - X(v2);
    dy = Y(v1) - Y(v2);

    len = sqrt(power(dx,2) + power(dy,2));

    totalLength = totalLength + len;
end

cost = 10 * numJoints + totalLength;
end

