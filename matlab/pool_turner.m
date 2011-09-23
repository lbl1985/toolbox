% function pool_turner(mode)
function pool_turner
% A wrapper for matlabpool open & matlabpool close
% switch mode
%     case 'open'
        try 
            matlabpool open
        catch %#ok<CTCH>
            matlabpool close
            matlabpool open
        end
%     case 'close'
%         try 
%             matlabpoo close
%         catch
%             ;
%         end
end