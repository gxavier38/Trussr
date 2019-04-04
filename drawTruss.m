function [] = drawTruss(C,X,Y,color)
%DRAWTRUSS Plots a truss
[~,numMembers] = size(C);

scatter(X,Y,color);
hold on;

for i = 1:numMembers
   row = find(C(:,i));
   v1 = row(1);
   v2 = row(2);
   plot([X(v1),X(v2)],[Y(v1),Y(v2)],color);
end

rectangle('Position', [-5 -20 5 20],'EdgeColor', 'green', 'FaceColor', 'green');
rectangle('Position', [54.5 -20 5 20], 'EdgeColor', 'green', 'FaceColor', 'green');

xlim([-5 59.5]);
ylim([-20 20]);

hold off;

end

