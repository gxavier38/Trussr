function [correct] = checkValid(C, X, Y, cost, lengthMatrix, print)
%VALID Checks whether a truss is valid
correct = true;

%% Verify input
[numJoints, numMembers] = size(C);

for i = 1:numMembers
    t = find(C(:,i));
    if (length(t) ~= 2)
        correct = false;
        if (print == true)
            disp("Member " + i + " is not connected to 2 joints");
        end 
    end
end

%% Validate cost
if (cost >= 320)
    correct = false;
    if (print == true)
        disp("Cost too high");
    end
end

%% Validate lengths
for i = 1:numMembers
    indices = find(C(:,i));
    v1 = indices(1);
    v2 = indices(2);
    
    if (lengthMatrix(i) < 10)
       correct = false;
       if (print == true)
           disp("Member between joints " + v1 + " and " + v2 + " too short");
       end
    end
    if (lengthMatrix(i) > 15)
       correct = false;
       if (print == true)
           disp("Member between joints " + v1 + " and " + v2 + " too long");
       end
    end
end

%% Check that joint exists between 20.5 and 21.5
if (isempty(find(X >= 20.5 & X <= 21.5)))
    correct = false;
    if (print == true)
        disp("No joint exists between 20.5 and 21.5");
    end    
end


%% Validate Joints and Members
if (numMembers ~= (2 * numJoints - 3))
    correct = false;
    if (print == true)
        disp("M = 2J - 3 not satisfied");
    end    
end

%% Check if any joints are above end points
if (~isempty(find(Y > 0)))
    correct = false;
    if (print == true)
        disp("Joints extend above end points");
    end
end

%% Check that joint exists at (0,0)
idx = find(X == 0);
temp = Y(idx);
if (isempty(idx) || isempty(temp == 0))
    correct = false;
    if (print == true)
        disp("No joint exists at (0,0)");
    end
end

%% Check that total length is 53.5 <= l <= 55.5 
maxX = max(X);
if (maxX <= 53.5 || maxX >= 55.5)
    correct = false;
    if (print == true)
        disp("Truss length is not 54.5");
    end
end
end

