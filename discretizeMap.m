function [grid] = discretizeMap(obs, mapSize, worldSize)
    grid = zeros(mapSize, mapSize);
    dimCell = worldSize/mapSize;

    xobs = obs.x;
    yobs = obs.y;
    N = size(xobs, 2);

    for scan=1:N
        xv = xobs{scan};
        yv = yobs{scan};
        for pos=1:length(xv)
            if ~isnan(xv(pos)) && ~isnan(yv(pos))
               [i,j] = getMapCell(xv(pos), yv(pos), worldSize, dimCell);
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

