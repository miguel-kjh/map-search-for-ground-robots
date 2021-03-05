clear all;
clc;

[pos, obs] = ExtractPathScans('mydata2021_03_02_17_13_30.log',pi/4);

vector_x = [];
vector_y = [];
max_grid = 20;


figure(1);
hold on;
plot(pos.x,pos.y);

for i = 1:length(obs.x)
    obs_x = obs.x{i};
    obs_y = obs.y{i};
    plot(obs_x, obs_y, '.');
end

grid = zeros(max_grid, max_grid);

elemente_ref = round(length(obs.x)/max_grid) - 1;


y_start = 1;
y_final = elemente_ref;

for i = 1:max_grid
    x_start = 1;
    x_final = elemente_ref;
    
    for j = 1:max_grid
        for position_x = x_start:x_final
            for position_y = y_start:y_final
                obs_x = obs.x{position_x};
                obs_y = obs.y{position_y};
                for index = 1:length(obs_x)
                    if ~isnan(obs_x(index)) && ~isnan(obs_y(index))
                        grid(i,j) = grid(i,j) + 1;
                    end
                end
            end
        end
        x_start = x_final;
        x_final = x_final + elemente_ref;
    end
    y_start = y_final;
    y_final = y_final + elemente_ref;
end

% disp(grid);

grid = grid - min(grid(:));
grid = grid ./ max(grid(:));

% disp(grid);

for j = 1:max_grid
    aux_i = max_grid;
    for i = 1:max_grid/2
        aux = grid(i,j);
        grid(i,j) = grid(aux_i, j);
        grid(aux_i, j) = aux;
        aux_i = aux_i - 1;
    end
end

% disp(grid);


figure(2);

surf(grid);
