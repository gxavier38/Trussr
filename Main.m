clear;
filename = 'trusses/Square Truss.mat';
check = true;
draw = true;

load(filename);

if (draw)
    drawTruss(C,X,Y,'black');
end

cost = getCost(C,X,Y);
lengthMatrix = getLengthMatrix(C,X,Y);
correct = checkValid(C,X,Y,cost,lengthMatrix,true);
if (check && ~correct)
    return
end

T = getForces(C,X,Y,L,Sx,Sy,lengthMatrix);

%% Results Display
[~,numMembers] = size(C);
[Trows,~] = size(T);
disp(newline);
disp("EK301, Section A2, Ben Glenn Eli Ahnaf Vikrant " + date);

% Loads
appliedLoad = L(find(L));
disp("Load in Newtons: " + appliedLoad);
disp("Member forces in Newtons:");

for i = 1:Trows
    if (abs(T(i)) < 0.0001)
        T(i) = 0;
    end
end

for i = 1:numMembers
    fType = "(T)";
    if (T(i) < 0) 
        fType = "(C)";
    elseif (T(i) == 0)
        fType = "";
    end
    disp("m" + i + ": " + abs(T(i)) + " " + fType);
end
disp("Reaction forces in Newtons:");
disp("Sx1: " + T(numMembers + 1));
disp("Sy1: " + T(numMembers + 2));
disp("Sy2: " + T(numMembers + 3));

% Metrics
disp("Cost of truss: $" + ceil(cost));

% Failure analysis
comp = zeros(numMembers,1);
for i = 1:numMembers
   if (T(i) >= 0)
       comp(i) = 0;
       continue;
   end
   comp(i) = -T(i);
end

bucklingForces = getBucklingForces(lengthMatrix);
scalingRatio = comp ./ bucklingForces;
[maxSR, maxSRindex] = max(scalingRatio);
maxLoad = appliedLoad / maxSR;
disp("Theoretical max load/cost ratio in N/$: " + maxLoad/cost);

disp(newline);
disp("Other statistics:");
disp("Maximum theoretical load in N: " + maxLoad);
disp("First member to buckle: " + maxSRindex);