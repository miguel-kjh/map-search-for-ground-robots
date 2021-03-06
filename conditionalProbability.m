
function [probFilled,probEmpty] = conditionalProbability(pos, obs, mapSize,worldSize)

    probEmpty = zeros(mapSize, mapSize);
    probFilled = zeros(mapSize, mapSize);
    
    dimCell = worldSize/mapSize;
    probEmpty(:) = 0.5;
    probFilled(:) = 0.5;
    
    
    xobs = obs.x;
    yobs = obs.y;
    countReadings = length(xobs);
    
    laserDistance = 12.5;
    maxAngle = 180;
    
    for scan=1:countReadings
        xv = xobs{scan};
        yv = yobs{scan};
        [robotI,robotJ] = getMapCell(pos.x(scan),pos.y(scan),dimCell);
 
        for position=1:length(xv)
            if ~isnan(xv(position)) && ~isnan(yv(position))
               [i,j] = getMapCell(xv(position), yv(position), dimCell);
               distance = getEuclideanDistance(i,j,robotI,robotJ);
               angle = getAngleObject(i,j,robotI,robotJ);
               
                   pFilled  = (( ( (laserDistance-distance)/laserDistance ) + ((maxAngle-angle)/ maxAngle ))  /2) * 0.98;
                   pEmpty =  1 - pFilled;
                   
                   aux  = (pEmpty*probEmpty(i,j) )/ ((pEmpty*probEmpty(i,j)) + (pFilled*probFilled(i,j)));
                   probFilled(i,j) = (pFilled*probFilled(i,j))/ ((pFilled*probFilled(i,j)) +(pEmpty*probEmpty(i,j) ));
                   probEmpty(i,j) = aux;

            end
        end
    end
    
end

function [angle] = getAngleObject(obsX,obsY,robotX,robotY)
    v1 = [obsX,obsY,0];
    v2 = [robotX,robotY,0];
   
    angle = atan2(norm(cross(v1,v2)), dot(v1,v2));
    angle = rad2deg(angle);
    
end


function [distance] = getEuclideanDistance(obsX,obsY,robotX,robotY)
    v1 = [obsX,obsY];
    v2 = [robotX,robotY];
    
    distance = norm(v1 - v2);
end

function [i,j] = getMapCell(x, y, dimCell)
    i = round(x/dimCell);
    j = round(y/dimCell);
    
    if i < 1; i = 1; end
    if j < 1; j = 1; end
end

