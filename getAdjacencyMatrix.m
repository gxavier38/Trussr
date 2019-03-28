function [A] = getAdjacencyMatrix(C)
%GETADJACENCYMATRIX Generates an adjacency matrix given an edge list
[numJoints,numMembers] = size(C);

A = zeros(numJoints, numJoints);
for i = 1:numMembers
    rows = find(C(:,i));
    v1 = rows(1);
    v2 = rows(2);
    
    A(v1,v2) = 1;
    A(v2,v1) = 1;
end
end

