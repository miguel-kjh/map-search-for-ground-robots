clc;
clear all;

mapResultFile = fullfile('results','map.csv');


grid = readtable(mapResultFile);

grid = grid{:,:};
grid(grid~=0) = 1;
start = [15 14];
final = [2, 2];

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
catch exception
    disp("map points not available");
end

