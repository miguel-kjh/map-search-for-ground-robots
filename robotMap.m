clear all;
clc;

[pos, obs] = ExtractPathScans('mydata2021_03_02_17_13_30.log',pi/4);

vector_x = [];
vector_y = [];
siseGrid = 26;


figure(1);
hold on;
plot(pos.x,pos.y);

for i = 1:length(obs.x)
    obs_x = obs.x{i};
    obs_y = obs.y{i};
    plot(obs_x, obs_y, '.');
end

grid = discretizeMap(obs, siseGrid);


figure(2);

surf(grid);
