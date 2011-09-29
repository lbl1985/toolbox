function ipAddress = getIpAddress()
if ispc
    [~, results] = system('ipconfig');
    startPoint = strfind(results, 'IPv4 Address') + 36;
    endPoint = strfind(results, 'Subnet Mask');
    ipAddress = results(startPoint : endPoint - 1);
elseif isunix
    [~, results] = system('ifconfig');
    startPoint = strfind(results, 'inet addr:') + length('inet addr:');
    endPoint = strfind(results, '  Bcast:');
    ipAddress = results(startPoint : endPoint);
end