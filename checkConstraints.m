function checkConstraints(grid, start, final)

    worlSize = size(grid,2);
    
    if (start(1) <= 0 || start(2) <= 0) || (start(1) > worlSize || start(2) > worlSize)
        ME = MException('myComponent:inputError', ...
        'Illegal start point, bab demension');
        throw(ME)
        
    elseif (final(1) <= 0 || final(2) <= 0) || (final(1) > worlSize || final(2) > worlSize)
        ME = MException('myComponent:inputError', ...
        'Illegal final point, bab demension');
        throw(ME)
      
    elseif start == final 
        ME = MException('myComponent:inputError', ...
        'Start point and final point must be different');
        throw(ME)
        
    elseif grid(final(2),final(1)) == 1
        ME = MException('myComponent:inputError', ...
        'Illegal final point, can not be an obstacle');
        throw(ME)
        
     elseif grid(start(2),start(1)) == 1
        ME = MException('myComponent:inputError', ...
        'Illegal start point, can not be an obstacle');
        throw(ME)
    
        
    end
    
    
end

