function [cost] = getCost(C, X, Y)
%COST Calculates the cost of a truss

[numJoints,~] = size(C);
rows = numJoints;
totalLength = 0;

for i = 1:rows
   [joint1index, joint2index] = find(C(:,i));
   
   dx = X(joint1index) - X(joint2index);
   dy = Y(joint1index) - Y(joint2index);

   len = sqrt(power(dx,2) + power(dy,2));
   
   totalLength = totalLength + len;
end 

cost = 10 * numJoints + totalLength;
end

