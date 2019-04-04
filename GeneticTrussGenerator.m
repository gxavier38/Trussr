clear;
loadfilename = 'trusses/Temp.mat';
savefilename = 'trusses/GeneticDesign0.mat';
check = false;
gens = 1000;
pop = 50;
protect = 10;
maxLocChange = 0.01;

load(loadfilename);

[numJoints, numMembers] = size(C);

bestX = zeros(pop,numJoints);
bestY = zeros(pop,numJoints);
bestFitness = zeros(pop,1);

for i = 1:protect
    bestX(i,:) = X;
    bestY(i,:) = Y;
    bestFitness(i) = getFit(C, bestX(i,:), bestY(i,:), L, Sx, Sy);
end
for i = (protect + 1):pop
    bestX(i,:) = mutate(X, maxLocChange);
    bestY(i,:) = mutate(Y, maxLocChange);
    bestFitness(i) = getFit(C, bestX(i,:), bestY(i,:), L, Sx, Sy);
end

figure;
l = animatedline();
maxBestFitness = max(bestFitness);
fprintf("Initial fitness is %f\n", maxBestFitness);
addpoints(l, 0, maxBestFitness);

%% Algorithm
for i = 1:gens
    [~,saveIdx] = maxk(bestFitness,protect);
    
    for j = 1:pop
        if (ismember(j,saveIdx))
            continue; 
        end
        
        v1 = select(bestFitness);
        v2 = select(bestFitness);
        tempX = crossover(bestX(v1,:), bestX(v2,:));
        tempY = crossover(bestY(v1,:), bestY(v2,:));
        tempX = mutate(tempX, maxLocChange);
        tempY = mutate(tempY, maxLocChange);
        bestX(j,:) = tempX;
        bestY(j,:) = tempY;
        bestFitness(j) = getFit(C, bestX(j,:), bestY(j,:), L, Sx, Sy);
    end
    
    maxBestFitness = max(bestFitness);
    fprintf("Fitness at generation %d is %f\n", i, maxBestFitness);
    addpoints(l, i, maxBestFitness);
    drawnow;
end

if (max(bestFitness) == -1 && check)
    return 
end

%% Draw and save trusses
figure;
drawTruss(C, X, Y, 'black');
hold on;
[~,idx] = max(bestFitness);
X = bestX(idx,:);
Y = bestY(idx,:);
drawTruss(C, X, Y, 'blue');
save(savefilename,'C','Sx','Sy','X','Y','L');

function [idx] = select(bestFitness)
    numJoints = length(bestFitness);
    idx = numJoints;
    total = sum(bestFitness);
    choice = rand * total;
    for i = 1:numJoints
        choice = choice - bestFitness(i);
        if (choice <= 0)
            idx = i;
            return
        end
    end
end

function [X] = crossover(X1,X2)
    numJoints = length(X1);
    X = X1;
    for k = 1:numJoints
         if (rand > 0.5)
            X(k) = X2(k);
         end
    end
end

function [M] = mutate(M, maxLocChange)
    numJoints = length(M);
    randMatrix = randn(numJoints,1) * maxLocChange;
    randMatrix(1) = 0;
    M = M + randMatrix.';
end