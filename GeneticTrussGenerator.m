clear;
loadfilename = 'trusses/Temp.mat';
savefilename = 'trusses/GeneticDesign0.mat';
check = false;
gens = 100;
pop = 100;
maxLocChange = 0.25;

load(loadfilename);

[numJoints, numMembers] = size(C);

bestX1 = X;
bestY1 = Y;
bestX2 = X;
bestY2 = Y;
bestFitness1 = getFit(C, X, Y, L, Sx, Sy);
bestFitness2 = bestFitness1;

figure;
l = animatedline();

%% Algorithm
for i = 1:gens
    tempBestX1 = bestX1;
    tempBestY1 = bestY1;
    tempBestX2 = bestX2;
    tempBestY2 = bestY2;
    tempBestFit1 = bestFitness1;
    tempBestFit2 = bestFitness2;
    
    for j = 1:pop
        tempX = bestX1;
        tempY = bestY1;
        
        % Crossover
        for k = 1:numJoints
             if (rand > 0.5)
                tempX(k) = bestX2(k);
             end
             if (rand > 0.5)
                tempY(k) = bestY2(k);
             end
        end
        
        % Mutation
        randMatrix = randn(numJoints,1) * maxLocChange;
        randMatrix(1) = 0;
        tempX = tempX + randMatrix.';
        randMatrix = randn(numJoints,1) * maxLocChange;
        randMatrix(1) = 0;
        tempY = tempY + randMatrix.';
        
        fitness = getFit(C, tempX, tempY, L, Sx, Sy);
        
        % Store results
        if (fitness >= tempBestFit1 && rand > 0.5)
            tempBestX1 = tempX;
            tempBestY1 = tempY;
            tempBestFit1 = fitness;
        else
            tempBestX2 = tempX;
            tempBestY2 = tempY;
            tempBestFit2 = fitness;
        end
    end
    
    bestX1 = tempBestX1;
    bestY1 = tempBestY1;
    bestX2 = tempBestX2;
    bestY2 = tempBestY2;
    bestFitness1 = tempBestFit1;
    bestFitness2 = tempBestFit2;
    
    maxBestFitness = max(bestFitness1, bestFitness2);
    fprintf("Fitness at generation %d is %f\n", i, maxBestFitness);
    addpoints(l, i, maxBestFitness);
    drawnow;
end

if (maxBestFitness == -1)
    return 
end

%% Draw and save trusses
figure;
drawTruss(C, X, Y, 'black');
hold on;

if (maxBestFitness == bestFitness1)
    X = bestX1;
    Y = bestY1;
else
    X = bestX2;
    Y = bestY2;
end
drawTruss(C, X, Y, 'blue');

save(savefilename,'C','Sx','Sy','X','Y','L');