clear;
loadfilename = 'trusses/Temp.mat';
savefilename = 'trusses/GeneticDesign0.mat';
check = false;
gens = 1000;
pop = 100;
maxLocChange = 0.25;

load(loadfilename);

[numJoints, numMembers] = size(C);

bestX = X;
bestY = Y;
bestFitness = getFit(C, X, Y, L, Sx, Sy);

figure;
l = animatedline();

%% Algorithm
for i = 1:gens
    tempBestX = bestX;
    tempBestY = bestY;
    tempBestFit = bestFitness;
    
    for j = 1:pop
        randMatrix = randn(numJoints,1) * maxLocChange;
        randMatrix(1) = 0;
        tempX = bestX + randMatrix.';
        randMatrix = randn(numJoints,1) * maxLocChange;
        randMatrix(1) = 0;
        tempY = bestY + randMatrix.';
        
        fitness = getFit(C, tempX, tempY, L, Sx, Sy);
        if (fitness >= tempBestFit)
            tempBestX = tempX;
            tempBestY = tempY;
            tempBestFit = fitness;
        end
    end
    
    bestX = tempBestX;
    bestY = tempBestY;
    bestFitness = tempBestFit;
    
    fprintf("Fitness at generation %d is %f\n", i, bestFitness);
    
    addpoints(l,i,bestFitness);
    drawnow;
end

if (bestFitness == -1)
    return 
end

%% Draw trusses
figure;
drawTruss(C, X, Y, 'black');
hold on;
drawTruss(C, bestX, bestY, 'blue');

%% Save generated truss
X = bestX;
Y = bestY;
save(savefilename,'C','Sx','Sy','X','Y','L');