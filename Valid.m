function [correct] = Valid(C, X, Y, cost, lengthMatrix)
%VALID Checks whether a truss is valid
correct = true;

%% Verify input
[numJoints, numMembers] = size(C);

for i = 1:numMembers
    t = find(C(:,i));
    if (length(t) ~= 2)
        correct = false;
        disp("Member " + i + " is not connected to 2 joints");
    end
end

%% Validate cost
if (cost >= 320)
    correct = false;
    disp("Cost too high");
end

%% Validate lengths
for i = 1:numMembers
    indices = find(C(:,i));
    v1 = indices(1);
    v2 = indices(2);
    
    if (lengthMatrix(i) < 10)
       correct = false;
       disp("Member between joints " + v1 + " and " + v2 + " too short");
    end
    if (lengthMatrix(i) > 15)
       correct = false;
       disp("Member between joints " + v1 + " and " + v2 + " too long");
    end
end

%% Validate Joints and Members
if (numMembers ~= (2 * numJoints - 3))
    correct = false;
    disp("M = 2J - 3 not satisfied");
end

%% Check that graph is planar
if (numMembers > (3 * numJoints - 6))
    correct = false;
    disp("Graph is non-planar");
end

%% Check that joint exists at 20.5 <= x <= 21.5
if (isempty(X <= 21.5 & X >= 20.5))
    correct = false;
    disp("No joint exists between 20.5 and 21.5cm");
end

%% Check that total length is >= 54.5
maxX = max(X);
if (maxX < 54.5)
    correct = false;
    disp("Truss is not long enough");
end

end

