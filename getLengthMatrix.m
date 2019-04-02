function [lengthMatrix] = getLengthMatrix(C, X, Y)
%GETLENGTHMATRIX Returns a matrix with the length of each member

[~,numMembers] = size(C);
lengthMatrix = zeros(numMembers,1);

for i = 1:numMembers
   indices = find(C(:,i));
   v1 = indices(1);
   v2 = indices(2);
   
   dx = X(v1) - X(v2);
   dy = Y(v1) - Y(v2);
   lengthMatrix(i) = sqrt(power(dx,2) + power(dy,2));
end
end

