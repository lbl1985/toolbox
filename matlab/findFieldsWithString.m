function fieldNames = findFieldsWithString(strVar, str)
% search for field name with certain string
% Input:
% strVar:       Structure varible
% str:          Searching string
% Output:
% fieldNames:   return fieldNames contains specific str as cell
%               array.

names = fieldnames(strVar);
nField = length(names);
indicator = false(nField, 1);
for i = 1 : nField
    if (~isempty(strfind(names{i}, str)))
        indicator(i) = true;
    end
end
fieldNames = names(indicator);
end