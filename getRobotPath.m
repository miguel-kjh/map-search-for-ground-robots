clc;
clear all;

mapResultFile = fullfile('results','map.csv');


grid = readtable(mapResultFile);

grid = grid{:,:};
grid(grid~=0) = 1;
start = [3, 3];
final = [35, 15];
heuritic = 'none';
eigthsNeighbors = true;

auxStart = grid(start(2), start(1));
auxFinal = grid(final(2), final(1));

figure(1);
grid(start(2), start(1)) = 2;
grid(final(2), final(1)) = -2;
pcolor(grid);
grid(start(2), start(1)) = auxStart;
grid(final(2), final(1)) = auxFinal;



try
    checkConstraints(grid, start, final)
    costMap = createCostMap(grid, start, final, eigthsNeighbors);
    figure(2);
    pcolor(costMap);
    [path,cost] = findPath(costMap, start, final, heuritic, eigthsNeighbors);
    figure(3);
    for i = 1:size(path,1)
        grid(path(i,2), path(i,1)) = -2;
    end
    pcolor(grid);
    fprintf('B&B-%s cost: %i\n',heuritic, cost);
catch exception
    disp("map points not available");
    throw(exception);
end




