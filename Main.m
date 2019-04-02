clear;
filename = 'PracticeProblem';
check = false;
draw = false;

load(filename);

if (draw)
    drawTruss(C,X,Y);
end

cost = getCost(C,X,Y);
lengthMatrix = getLengthMatrix(C,X,Y);
correct = Valid(C,X,Y,cost,lengthMatrix);
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
load = L(find(L));
disp("Load in Newtons: " + load);
disp("Member forces in Newtons:");
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
   if (T(i) > 0)
       comp(i) = inf;
       continue;
   end
   comp(i) = -T(i);
end

bucklingForces = getBucklingForces(lengthMatrix);
scalingRatio = bucklingForces ./ comp;
[maxSR, maxSRindex] = max(scalingRatio);
maxLoad = 1 / maxSR;
disp("Theoretical max load/cost ratio in N/$: " + maxLoad/cost);

disp(newline);
disp("Other statistics:");
disp("Maximum theoretical load in N: " + maxLoad);
disp("First member to buckle: " + maxSRindex);


