function [costMap] = createCostMap(grid, start, final, nearest8Neighbors)

    costMap = grid;
    initialCost = 2;
    costMap(final(2),final(1)) = initialCost;
    worlSize = size(grid,2);
    listDimension = worlSize*worlSize;
    
    list = zeros(listDimension, 3);
    listIndex = 1;
    finalListIndex = listIndex + 1;
    list(listIndex,1) = final(1);
    list(listIndex,2) = final(2);
    list(listIndex,3) = initialCost;
    
    evalPoint = [list(listIndex,1), list(listIndex,2)];
%     figure(3);
%     hold on;
    
    while(  ~( evalPoint(1) == start(1) && evalPoint(2) == start(2)))
        costFather = list(listIndex,3);
        costChild = costFather + 1;
        if (nearest8Neighbors)
            nearestNeighbors = get8nearestNeighbors(evalPoint);
        else 
            nearestNeighbors = get4nearestNeighbors(evalPoint);
        end
        
        for i=1:length(nearestNeighbors)
            x = nearestNeighbors(i,1);
            y = nearestNeighbors(i,2);
            
            if (x > 0 && y > 0) && (x <= worlSize && y <= worlSize) && costMap(y,x) == 0
                costMap(y,x) = costChild;
                list(finalListIndex,1) = x;
                list(finalListIndex,2) = y;
                list(finalListIndex,3) = costChild;
                finalListIndex = finalListIndex + 1;
            end
        end
        
        listIndex = listIndex + 1;
        evalPoint = [list(listIndex,1), list(listIndex,2)];
        
    end
end




