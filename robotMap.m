clear all;
clc;

[pos, obs] = ExtractPathScans('mydata2021_03_02_17_13_30.log',pi/4);

vector_x = [];
vector_y = [];
siseGrid = 26;


plotMap2D(pos, obs);

grid = discretizeMap(obs, siseGrid);

plotMap3D(grid);



