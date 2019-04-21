clear;
filename = 'trusses/Bridge2.mat';

load(filename);

[numJoints,~] = size(C);

for i = 1:numJoints
    disp("Plate number " + i);
    x = X(i);
    y = Y(i);
    members = find(C(i,:));
    
    for j = 1:length(members)
        temp = C(:,members(j));
        temp(i) = 0;
        joint = find(temp ~= 0);
        
        dy = Y(joint) - y;
        dx = X(joint) - x;
        angle = round(atand(abs(dy/dx)));
        
        if (dx < 0 && dy < 0)
            angle = angle + 180;
        elseif (dx < 0)
            angle = 180 - angle;
        elseif (dy < 0)
            angle = 360 - angle;
        end
        
        disp("Angle to joint " + joint + " is " + angle + " degrees");
    end
end