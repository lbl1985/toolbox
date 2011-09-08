function play(obj)
%support function for videoVar class
%   play the videoVar data
    for t = 1 : obj.nFrame
        if obj.ndim == 3
            imshow(obj.Data(:, :, t));    
        else
            imshow(obj.Data(:, :, :, t)); 
        end
        title(['Frame ' num2str(t)]);
        pause(1/22);
    end
end

