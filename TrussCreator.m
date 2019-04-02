clear;
draw = false;
check = true;
filename = 'TrussDesign1_BenGlennEliAhnafVikrant_A2.mat';

C = [1 1 0 0 0 0 0
     1 0 1 0 1 1 0
     0 1 1 1 0 0 0
     0 0 0 1 1 0 1
     0 0 0 0 0 1 1];
Sx = [1 0 0
      0 0 0
      0 0 0
      0 0 0
      0 0 0];
Sy = [0 1 0
      0 0 0
      0 0 0
      0 0 0
      0 0 1];
X = [0 15 7.5 21.5 30];
Y = [0 0 -10 -10 0];
L = [0
     0
     0
     0
     0
     0
     0
     0
     0.5 * 9.81
     0];

[numJoints, numMembers] = size(C);
assert(length(X) == numJoints);
assert(length(Y) == numJoints);
assert(size(Sx,1) == numJoints);
assert(size(Sy,1) == numJoints);
assert(size(L,1) == numJoints * 2);
 
if (draw)
    drawTruss(C,X,Y);
end

cost = getCost(C,X,Y);
lengthMatrix = getLengthMatrix(C,X,Y);
correct = Valid(C,X,Y,cost,lengthMatrix);
lengthMatrix = getLengthMatrix(C,X,Y);

if (check && ~correct)
    return
end

save(filename,'C','Sx','Sy','X','Y','L');