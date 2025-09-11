function rawData = parseCSV(filename)
    fid = fopen(filename, 'r');
    if fid == -1
        error('Cannot open file: %s', filename);
    end

    rawData = {};
    current_line = fgetl(fid);
    while ischar(current_line)
        rawData{end+1} = current_line; % Store each line of the file
        current_line = fgetl(fid);
    end
    fclose(fid);

    arrayData = cell2mat(rawData);
end