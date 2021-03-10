function [costMap] = createCostMap(grid, start, final)
    costMap = grid;
    costMap(final(1),final(2)) = 2;
    
    cost = 2;
    
    list = [];
    list = cat(1,list,[final cost]);
   
    listIndex = 1;
    
    point1 = list(1);
    point2 = list(2);
    
    while(  ~( point1 == start(1) && point2 == start(2)))
        
        if (point1 - 1) > 0 && (point2 - 1) > 0
              
            if costMap(point1, (point2 -1) ) == 0 
                
                costMap(point1, (point2 -1) ) = cost + 1;
                list = cat(1,list,[point1, (point2 -1), (cost + 1) ]);
                
            end
            
            if  costMap( (point1 - 1), point2) == 0 
                
                costMap( (point1 - 1), point2) = cost + 1;
                list = cat(1,list,[(point1-1),point2 , (cost + 1)]);
                
            end
            
        end    
          
       % Cuando el valor del nuevo vecinmo generado es distinto de 0 entonces
       % ya se había generado anteriormente
       % utilizar indice para acceder a la lista
        
        if (point1 + 1) <26 && (point2 + 1)  < 26
            
             if costMap(point1, (point2 +1) ) == 0 
                 
                costMap(point1, (point2 +1) ) = cost + 1; 
                list = cat(1,list,[point1,(point2 +1) , (cost + 1) ]);
                
             end
            
             if  costMap( (point1 + 1), point2) == 0 
                 
                 costMap( (point1 + 1), point2) = cost + 1;
                 list = cat(1,list,[(point1 + 1),point2, (cost + 1)]);
                 
             end
      
            
        end 
        
        listIndex = listIndex + 1;
        
        
        point1 = list(listIndex, 1);
        point2 = list(listIndex, 2);
        cost = list(listIndex, 3);
        
        
    end
   
    costMap
    costMap(start(1),start(2))  
end

