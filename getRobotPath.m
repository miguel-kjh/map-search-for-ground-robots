clear all;
clc;

grid = readtable('map.csv');

grid = grid{:,:};

grid(grid>0.85) = 1;
grid(grid<0.85) = 0;

findPath(grid, [22 5], [10 10])

function [] = findPath(grid, start, final)

    grid(final(1),final(2)) = 2;
    
    cost = 2;
    
    list = [];
    list = cat(1,list,[final cost]);
   
    listIndex = 1;
    
    point1 = list(1);
    point2 = list(2);
    
    while(  ~( point1 == start(1) && point2 == start(2)))
        
        if (point1 - 1) > 0 && (point2 - 1) > 0
              
            if grid(point1, (point2 -1) ) == 0 && grid(point1, (point2 +1) ) ~= 1
                
                grid(point1, (point2 -1) ) = cost + 1;
                list = cat(1,list,[point1, (point2 -1), (cost + 1) ]);
                
            end
            
            if  grid( (point1 - 1), point2) == 0 && grid(point1, (point2 +1) ) ~= 1
                
                grid( (point1 - 1), point2) = cost + 1;
                list = cat(1,list,[(point1-1),point2 , (cost + 1)]);
                
            end
            
        end    
          
       % Cuando el valor del nuevo vecinmo generado es distinto de 0 entonces
       % ya se había generado anteriormente
       % utilizar indice para acceder a la lista
        
        if (point1 + 1) <26 && (point2 + 1)  < 26
            
             if grid(point1, (point2 +1) ) == 0 && grid(point1, (point2 +1) ) ~= 1
                 
                grid(point1, (point2 +1) ) = cost + 1; 
                list = cat(1,list,[point1,(point2 +1) , (cost + 1) ]);
                
             end
            
             if  grid( (point1 + 1), point2) == 0 && grid(point1, (point2 +1) ) ~= 1
                 
                 grid( (point1 + 1), point2) = cost + 1;
                 list = cat(1,list,[(point1 + 1),point2, (cost + 1)]);
                 
             end
      
            
        end 
        
        listIndex = listIndex + 1;
        
        
        point1 = list(listIndex, 1);
        point2 = list(listIndex, 2);
        cost = list(listIndex, 3);
        
        
    end
   
    grid
    grid(start(1),start(2))

end
