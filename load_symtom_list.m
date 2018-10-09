function symtom_list = load_symtom_list()
% load_symtom_list reads the fixed movie list in data.txt and returns a
% cell array of the words


%% Read the symtom list
fid = fopen('data.txt');

% Store all symtom in cell array movie{}
n = 50;  % Total number of symtom
symtom_list = cell(n, 1);
for i = 1:n
    % Read line
    line = fgets(fid);
    % Word Index (can ignore since it will be = i)
    [idx, symtom] = strtok(line, ' ');
    % Actual Word
    symtom_list{i} = strtrim(symtom);
end
fclose(fid);

end