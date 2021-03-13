clc;
clear all;

filename   = fullfile('data','mydata2021_03_02_17_13_30.log');
mapResultFile = fullfile('results','map.csv');
[pos, obs] = ExtractPathScans(filename,pi/4);

vector_x  = [];
vector_y  = [];
mapSize   = 25;
worldSize = 16;

plotMap2D(pos, obs);

grid = discretizeMap(obs, mapSize, worldSize);

plotMap3D(grid);

csvwrite(mapResultFile, grid);



