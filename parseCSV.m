function rawData = parseCSV(filename)
    % Get file ID for input filename
    fid = fopen(filename, 'r');
    % Check if the file opened successfully
    if fid == -1
        error('Cannot open file: %s', filename);
    end
    % Initialize variable array for data
    rawData = {};
    % Initialize the line we are looking at to first line in file
    current_line = fgetl(fid);
    while ischar(current_line) % As long as our current line has something
        % in it, it will continue looping

        % Convert the current line to a number and store it
        current_line_convert_int = str2double(current_line);

        % Increases size of rawData and stores number
        rawData{end+1} = current_line_convert_int;

        % read the next line of file and store in current_line
        current_line = fgetl(fid);
    end
    fclose(fid); % you know what this done :)

    % Converts the cell array to an ordinary array for use in cusum and
    % returns value to calling function
    rawData = cell2mat(rawData);
end