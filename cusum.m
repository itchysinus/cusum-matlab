% Data input. Needs filename, confidence, and number of bootstraps.
fprintf("Type the file name:");
fileName = input('', "s");
fprintf("What is your desired confidence interval?");
confidence = input('');
while confidence < 0 || confidence > 1
    fprintf("Uh oh. That's going to be a problem. Give a confidence interval between 0 and 1.");
    confidence = input('');
end
fprintf("What is the number of bootstraps?");
bootstraps = input('');

% Parse the data file that has been inputted. Will fail if file does not
% exist (see parseCSV.m)
data = parseCSV(fileName);

% Allow all plotting on a single graph
hold on;
% Make scale for data on right side
yyaxis right;
% Plot raw data
plot(data, 'Color', [0,0.9,0.9,0.1]);
% Put scale for everything else on the left
yyaxis left;

% Run the cusum function (called mucus b/c LOL)
changepoints = mucus(data, confidence, bootstraps, 0);

% Output changepoints
for i = 1:length(changepoints)
    fprintf("Changepoint %d: %d\n", i, changepoints(i));
end

%% MUCUS FUNCTION
% Takes in an array of numbers, a desired confidence level, a number of
% times to perform bootstrapping, and the index of the beginning of the
% data.
% Returns the indicies of where a change in the mean was detected in the
% original array of numbers
function changepoints = mucus(data, confidence, bootstraps, start)
    % Create an array to hold the results
    changepoints = [];
    % Find the average
    data_avg = mean(data);
    % Calculate the lenght of the array
    length_data = length(data);
    % Create an array to hold the cusum value points
    cusumData = zeros(1, length_data + 1);
    
    % Calculate the cusum from the data. 
    for i = 1:length_data
        cusumData(i+1) = cusumData(i) + (data(i) - data_avg);
    end
    
    % Calculate the difference between the maximum of the cusum and the
    % minimum of the cusum
    OGDiff = max(cusumData) - min(cusumData);

    % Bootstrap the data to determine if it is statistically significant.
    % If so, run the code to record the data point and further break up the
    % data.
    if(bootstrap(data, OGDiff, data_avg, bootstraps) > confidence)
        % Generate an array of consecutive integers starting at the index
        % of where the array or subarray begins.
        x_vals = start + (1:length_data + 1);
        % Plot the cusum on the graph of the data, using x_vals for the
        % x-values and cusumData for the y-values
        plot(x_vals, cusumData, '*r');
        
        % Determine the index of the point furthest from 0 in the cusum
        [~, index] = max(abs(cusumData));
        % Set the change point at 1 below the index since it would have
        % moved forward 1 because of the cusum
        cp = index - 1;

        % Perform a cusum recursively on the data on the left of the
        % changepoint and then recursively on the data on the right of the
        % changepoint
        left = mucus(data(1:cp), confidence, bootstraps, start);
        right = mucus(data(cp:end), confidence, bootstraps, cp);
        % Correct the right changepoint by shifting it over from 0 by the
        % changepoint. Subtract 1 for addition correction
        right = right + cp - 1;

        % Capture the results of the cusum analysis in an array.
        changepoints = [left, cp, right];
    end
    return;

end

