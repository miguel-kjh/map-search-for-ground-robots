function [nearestNeighbors] = get8nearestNeighbors(point)
    x = point(1);
    y = point(2);
    nearestNeighbors = [
        [x,y+1]
        [x+1,y]
        [x,y-1]
        [x-1,y]
        [x-1,y+1]
        [x-1,y-1]
        [x+1,y+1]
        [x+1,y-1]
    ];
end

