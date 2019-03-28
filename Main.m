filename = 'TrussDesign0_SampleFromProjectManual';
check = true;
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
disp(T);