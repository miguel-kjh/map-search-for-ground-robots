clc;
clear all;

mapResultFile = fullfile('results','map.csv');


grid = readtable(mapResultFile);

grid = grid{:,:};
grid(grid~=0) = 1;
start = [18, 16];
final = [13, 2];
heuritic = 'ecludian';

figure(1);
grid(start(2), start(1)) = 2;
grid(final(2), final(1)) = -2;
pcolor(grid);
grid(start(2), start(1)) = 0;
grid(final(2), final(1)) = 0;

try
    costMap = createCostMap(grid, start, final);
    figure(2);
    pcolor(costMap);
    [path,cost] = findPath(costMap, start, final);

    figure(3);
    for i = 1:length(path)
        grid(path(i,2), path(i,1)) = -2;
    end
    pcolor(grid);
    fprintf('B&B-%s cost: %i\n',heuritic, cost);
catch exception
    disp("map points not available");
    throw(exception);
end


