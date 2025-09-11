function rawData = parseCSV(filename)
    fid = fopen(filename, 'r');
    if fid == -1
        error('Cannot open file: %s', filename);
    end

    rawData = {};
    current_line = fgetl(fid);
    while ischar(current_line)
        current_line_convert_int = str2double(current_line);
        rawData{end+1} = current_line_convert_int; % Store each line of the file
        current_line = fgetl(fid);
    end
    fclose(fid);

    rawData = cell2mat(rawData);
end