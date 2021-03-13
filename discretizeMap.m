
function [grid] = discretizeMap(obs, mapSize, worldSize)
    grid = zeros(mapSize, mapSize);
    dimCell = worldSize/mapSize;

    xobs = obs.x;
    yobs = obs.y;
    countReadings = length(xobs);

    for scan=1:countReadings
        xv = xobs{scan};
        yv = yobs{scan};
        for pos=1:length(xv)
            if ~isnan(xv(pos)) && ~isnan(yv(pos))
               [i,j] = getMapCell(xv(pos), yv(pos), dimCell);
               grid(i,j) = grid(i,j) + 1;  
            end
        end
    end
    
    grid = normalizeGrid(grid.');
    
end

function [grid] = normalizeGrid(grid)
    grid = grid ./ max(grid(:));
end

function [i,j] = getMapCell(x, y, dimCell)
    i = round(x/dimCell);
    j = round(y/dimCell);
    
    if i < 1; i = 1; end
    if j < 1; j = 1; end
end

