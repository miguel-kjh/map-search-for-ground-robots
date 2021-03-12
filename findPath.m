% TODO: check if child point is not in list

function [path, cost] = findPath(costMap, start, final)
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
            
            if (x > 0 && y > 0) && (x <= worlSize && y <= worlSize) && costMap(y,x) > 1 && ~searchPoint(list, [x,y])
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
        evalPoint = pointToEvaluate(1,:);
    end
    path = evalPoint;
    fatherIndex = evalPoint(4);
    cost = evalPoint(3);
    
    while(fatherIndex ~= 0)
        path = [path; list(fatherIndex,:)];
        fatherIndex = list(fatherIndex,4);
    end
    
end


function [isPoint] = searchPoint(list, point)
    for i = 1:length(list)
        if list(i,1) == point(1) && list(i,2) == point(2)
            isPoint = true;
            return
        end
    end
    isPoint = false;
end

