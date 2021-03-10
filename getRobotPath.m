clear all;
clc;
mapResultFile = fullfile('results','map.csv');


grid = readtable(mapResultFile);

grid = grid{:,:};

grid(grid~=0) = 1;

costMap = createCostMap(grid, [4 4], [8 12]);

figure(1);
pcolor(grid);

figure(2);
pcolor(costMap);

