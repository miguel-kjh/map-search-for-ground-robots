% TODO: check if child point is not in list

function [path] = findPath(costMap, start, final)
    worlSize = size(costMap,2);
    listDimension = worlSize*worlSize;
    
    list = zeros(listDimension, 4);
    listIndex = 1;
    finalListIndex = listIndex + 1;
    list(listIndex,1) = start(1);
    list(listIndex,2) = start(2);
    list(listIndex,3) = costMap(start(2),start(1));
    list(listIndex,4) = 0;
    
    evalPoint = list(listIndex,:);

    while(  ~( evalPoint(1) == final(1) && evalPoint(2) == final(2)))
        nearestNeighbors = get4nearestNeighbors(evalPoint);
        
        for i=1:length(nearestNeighbors)
            x = nearestNeighbors(i,1);
            y = nearestNeighbors(i,2);
            
            if (x > 0 && y > 0) && (x <= worlSize && y <= worlSize) && costMap(y,x) > 1
                list(finalListIndex,1) = x;
                list(finalListIndex,2) = y;
                list(finalListIndex,3) = costMap(y,x) + evalPoint(3);
                list(finalListIndex,4) = listIndex;
                finalListIndex = finalListIndex + 1;
            end
        end
        
        listIndex = listIndex + 1;
        pointToEvaluate = list(listIndex:finalListIndex,:);
        sortrows(pointToEvaluate,3);
        evalPoint = pointToEvaluate(1,:)
    end
    path = evalPoint;
end