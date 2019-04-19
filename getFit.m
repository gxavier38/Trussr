function [fitness] = getFit(C, X, Y, L, Sx, Sy)
%GETFIT Calculates the maxLoad/cost ratio of a truss
fitness = -1;

cost = getCost(C,X,Y);
lengthMatrix = getLengthMatrix(C,X,Y);

correct = checkValid(C,X,Y,cost,lengthMatrix,false);
if (~correct)
    return;
end

T = getForces(C,X,Y,L,Sx,Sy,lengthMatrix);

[~,numMembers] = size(C);

% Failure analysis
comp = zeros(numMembers,1);
for i = 1:numMembers
   if (T(i) > 0)
       comp(i) = inf;
       continue;
   end
   comp(i) = -T(i);
end

bucklingForces = getBucklingForces(lengthMatrix);
scalingRatio = comp ./ bucklingForces;
[maxSR, ~] = max(scalingRatio);
maxLoad = load / maxSR;
fitness = maxLoad/cost;
end

