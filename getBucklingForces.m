function [forces] = getBucklingForces(lengthMatrix)
%GETBUCKLINGFORCES Returns a matrix with the buckling force of each member

[numMembers,~] = size(lengthMatrix);
forces = zeros(numMembers,1);

for i = 1:numMembers
    forces(i,1) = 1384.4 / power(lengthMatrix(i), 2);
end
end

