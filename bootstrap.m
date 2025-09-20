%% BOOTSTRAP FUNCTION
% Function to test if max to min range of an array is statistically
% significant.
% Takes in an array of integer data, the difference between the max and min
% of the cusum of that data, the average of the data, and the number of
% times to rearrange the data and compare the results to the original.
% Returns a fraction that is the number of times max - min of the cusum of
% the bootstrapped data was less than the original difference.
function significance = bootstrap(data, OGDiff, aver, bootstraps)
    % Variable to increment if bootstrap diff is less than original
    notable = 0;
    
    % Loop to run the bootstrap the specified number of times
    for i = 1:bootstraps
        % Create a shuffled array
        newData = fisherYatesShuffle(data);
        % Calculate the length of the data
        data_size = length(data);
        % Create an array to hold the cusum of the rearranged data
        compCusum = zeros(1, data_size + 1);

        % Perform a cusum on the rearranged data
        for j = 1:data_size
            compCusum(j + 1) = compCusum(j) + newData(j) - aver;
        end

        % Calculated the difference between the maximum and the minimum of
        % the cusum
        newDiff = max(compCusum) - min(compCusum);

        % Note another success if the new difference is less than the
        % original
        if newDiff < OGDiff
            notable = notable + 1;
        end
    end

    % Make a fraction: the number of times the difference between max and
    % min was less than the original divided by the number of times you
    % rearranged the data and checked.
    significance = notable/bootstraps;
end

%% FISHER YATES SHUFFLE
% Function to shuffle an array of integers using the fisher yates method
% Takes in an array of integers
% Returns the array of shuffled integers
function shuffledArray = fisherYatesShuffle(inputArray)
    shuffledArray = inputArray; % Initialize shuffledArray
    n = length(inputArray); % Get the length of the input array
    for i = n:-1:2
        j = randi(i); % Generate a random index
        % Swap elements
        temp = shuffledArray(i);
        shuffledArray(i) = shuffledArray(j);
        shuffledArray(j) = temp;
    end
end
