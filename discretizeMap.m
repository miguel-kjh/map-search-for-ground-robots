function [grid] = discretizeMap(obs, mapSize, worldSize)
    grid = zeros(mapSize, mapSize);
    dimCell = worldSize/mapSize;

    xobs = obs.x;
    yobs = obs.y;
    N = size(xobs, 2);

    for c=1:N
        xv = xobs{c};
        yv = yobs{c};
        for k=1:length(xv)
            if ~isnan(xv(k)) && ~isnan(yv(k))
               [i,j] = getMapCell(xv(k), yv(k), worldSize, dimCell);
               grid(i,j) = grid(i,j) + 1;  
            end
        end
    end
    
    grid = normalizeGrid(grid.');
    
end

function [grid] = normalizeGrid(grid)
    grid = grid ./ max(grid(:));
end

function [i,j] = getMapCell(x, y, worldSize, dimCell)

    if x > worldSize; x = worldSize; end
    if y > worldSize; y = worldSize; end
    if x < 0; x = 1; end
    if y < 0; y = 1; end
    
    i = ceil(x/dimCell);
    j = ceil(y/dimCell);
end

