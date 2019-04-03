clear;
loadfilename = 'TrussDesign0_SampleFromProjectManual.mat';
savefilename = 'GeneticDesign0.mat';
check = false;
gens = 5000;
perGen = 100;
indChange = 10;
maxLocChange = 2;

load(loadfilename);

[numJoints, numMembers] = size(C);

bestX = X;
bestY = Y;
bestL = L;
bestFitness = getFit(C, X, Y, L, Sx, Sy);

for i = 1:gens
    tempbestX = bestX;
    tempbestY = bestY;
    tempbestL = bestL;
    tempbestFitness = bestFitness;
    
    for j = 1:perGen
        randMatrix = (2 * maxLocChange) * rand(numJoints,1) - maxLocChange;
        X = bestX + randMatrix.';
        randMatrix = (2 * maxLocChange) * rand(numJoints,1) - maxLocChange;
        Y = bestY + randMatrix.';
        
        ind = find(X >= 20.5 & X <= 21.5);
        if (isempty(ind))
            continue;
        end
        
        [~,ind] = min(Y(ind));
        L = zeros(numJoints * 2, 1);
        L(numJoints + ind, 1) = 1;
        
        fitness = getFit(C, X, Y, L, Sx, Sy);
        if (fitness > bestFitness)
           tempbestX = X;
           tempbestY = Y;
           tempbestL = L;
           tempbestFitness = fitness;
        end
    end
    
    bestX = tempbestX;
    bestY = tempbestY;
    bestL = tempbestL;
    bestFitness = tempbestFitness;
    
    disp("Fitness at generation " + i + " is " + bestFitness);
end


if (bestFitness ~= 1)
    return 
end

X = bestX;
Y = bestY;
L = bestL;

drawTruss(C, X, Y);
save(filename,'C','Sx','Sy','X','Y','L');