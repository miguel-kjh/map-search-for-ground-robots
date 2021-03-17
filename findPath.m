function [path, cost] = findPath(costMap, start, final, heuristic, nearest8Neighbors)
    worlSize = size(costMap,2);
    listDimension = worlSize*worlSize;
    
    list = zeros(listDimension, 5);
    listIndex = 1;
    finalListIndex = listIndex + 1;
    list(listIndex,1) = start(1); % x
    list(listIndex,2) = start(2); % y
    list(listIndex,3) = costMap(start(2),start(1)); % cost
    list(listIndex,4) = 0; % father index
    list(listIndex,5) = costMap(start(2),start(1)) + calculateHeuristic(start, final, heuristic); % cost + heuristics
    
    evalPoint = list(listIndex,:);

    while(  ~( evalPoint(1) == final(1) && evalPoint(2) == final(2)))
        if (nearest8Neighbors)
            nearestNeighbors = get8nearestNeighbors(evalPoint);
        else 
            nearestNeighbors = get4nearestNeighbors(evalPoint);
        end
        
        for i=1:length(nearestNeighbors)
            x = nearestNeighbors(i,1);
            y = nearestNeighbors(i,2);
            
            if (x > 0 && y > 0) && (x <= worlSize && y <= worlSize) && costMap(y,x) > 1 && ~searchPoint(list, [x,y])
                list(finalListIndex,1) = x;
                list(finalListIndex,2) = y;
                list(finalListIndex,3) = costMap(y,x) + evalPoint(3);
                list(finalListIndex,4) = listIndex;
                list(finalListIndex,5) = list(finalListIndex,3) + calculateHeuristic([x,y], final, heuristic);
                finalListIndex = finalListIndex + 1;
                
            end
        end
        
        listIndex = listIndex + 1;
        pointToEvaluate = list(listIndex:finalListIndex,:);
        sortrows(pointToEvaluate,5);
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

function [value] = calculateHeuristic(p1,p2,heuristic)
    if heuristic == "euclidean"
        value =  pdist2(p1,p2, 'euclidean');
    elseif heuristic == "manhatan"
        value =  sum(abs(p1-p2));
    else
        value = 0;
    end
end

