clear;
draw = true;
check = true;
filename = 'trusses/Temp.mat';

C = [1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
     1 0 1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
     0 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
     0 0 0 0 1 1 1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0
     0 0 0 1 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0
     0 0 0 0 0 0 0 0 1 1 1 0 0 1 0 0 0 0 0 0 0 0 0
     0 0 0 0 0 0 0 1 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0
     0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0 1 0 0 0 0 0
     0 0 0 0 0 0 0 0 0 0 0 1 0 0 1 1 1 0 0 0 0 0 0
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0 1 0
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1 1 1 0 0
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1];
Sx = [1 0 0
      0 0 0
      0 0 0
      0 0 0
      0 0 0
      0 0 0
      0 0 0
      0 0 0
      0 0 0
      0 0 0
      0 0 0
      0 0 0
      0 0 0];
Sy = [0 0 0
      0 0 0
      0 0 0
      0 0 0
      0 0 0
      0 0 0
      0 0 0
      0 0 0
      0 0 0
      0 0 0
      0 0 0
      0 0 0
      0 1 1];
X = [0 5 10 15 21 26 32 36 42 46 52 56 63];
Y = [0 -10 -1 -11 -3 -14 -2 -13 0 -12 0 -12 0];
L = [0
     0
     0
     0
     0
     0
     0
     0
     0
     0
     0
     0
     0
     0
     0
     0
     0
     1000
     0
     0
     0
     0
     0
     0
     0
     0];

[numJoints, numMembers] = size(C);
assert(length(X) == numJoints);
assert(length(Y) == numJoints);
assert(size(Sx,1) == numJoints);
assert(size(Sy,1) == numJoints);
assert(size(L,1) == numJoints * 2);
 
if (draw)
    drawTruss(C,X,Y,'black');
end

cost = getCost(C,X,Y);
lengthMatrix = getLengthMatrix(C,X,Y);
correct = checkValid(C,X,Y,cost,lengthMatrix,true);

if (check && ~correct)
    return
end

save(filename,'C','Sx','Sy','X','Y','L');