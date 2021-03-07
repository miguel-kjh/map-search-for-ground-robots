function [grid] = discretizeMap(obs, sizeMap)
    grid = zeros(sizeMap, sizeMap);

    elemente_ref = round(length(obs.x)/sizeMap);


    y_start = 1;
    y_final = elemente_ref;

    for i = 1:sizeMap
        x_start = 1;
        x_final = elemente_ref;

        for j = 1:sizeMap
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
    
    % for j = 1:max_grid
    %     aux_i = max_grid;
    %     for i = 1:max_grid/2
    %         aux = grid(i,j);
    %         grid(i,j) = grid(aux_i, j);
    %         grid(aux_i, j) = aux;
    %         aux_i = aux_i - 1;
    %     end
    % end
    
    normalizeGrid(grid)
    
end

function [] = normalizeGrid(grid)
    grid = grid - min(grid(:));
    grid = grid ./ max(grid(:));
end

