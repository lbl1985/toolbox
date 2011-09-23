function isOK = memoryCheck(limit)
isOK = false;
if ispc
    [~, sys] = memory;
    if sys.PhysicalMemory.Total > limit
       isOK = true;
    end
elseif isunix
    [~, m] = unix('cat /proc/meminfo');
    k = strfind(m, 'MemFree:');
    memTotal = m(10:k - 4);
    % memTotal is kB
    memTotal = str2double(memTotal);
    % memTotal is B
    memTotal = memTotal * 1024;
    if memTotal > limit
        isOK = true;
    end
end


