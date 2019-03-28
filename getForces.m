function [T] = getForces(C, X, Y, L, Sx, Sy, lengthMatrix)
%FORCES Returns the force experienced by each member
[numJoints, numMembers] = size(C);

%% Get A matrix
Ax = zeros(numJoints, numMembers);
Ay = zeros(numJoints, numMembers);

for i = 1:numMembers
    rows = find(C(:,i));
    v1 = rows(1);
    v2 = rows(2);
    len = lengthMatrix(i);

    Ax(v1,i) = (X(v1) - X(v2)) / len;
    Ax(v2,i) = -(X(v1) - X(v2)) / len;

    Ay(v1,i) = (Y(v1) - Y(v2)) / len;
    Ay(v2,i) = -(Y(v1) - Y(v2)) / len;
end

%% Calculate forces
A = [Ax Sx; Ay Sy];

[rowsA, colsA] = size(A);
assert(rowsA == 2 * numJoints);
assert(colsA == numMembers + 3);

T = inv(A) * L;
end

