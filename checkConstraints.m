function checkConstraints(grid, start, final)
    
    if grid(start(2),start(1)) == 1
        ME = MException('myComponent:inputError', ...
        'Illegal start point, can not be an obstacle');
        throw(ME)
    elseif grid(final(2),final(1)) == 1
        ME = MException('myComponent:inputError', ...
        'Illegal final point, can not be an obstacle');
        throw(ME)
    
    elseif start == final 
        ME = MException('myComponent:inputError', ...
        'Start point and final point must be different');
        throw(ME)
    
    
    end
    
    
end
