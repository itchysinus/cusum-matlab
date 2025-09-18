function a = bootstrap(data, OGDiff, aver, bootstraps)
    notable = 0;
    for i = 1:bootstraps
        newData = fisherYatesShuffle(data);
        sizie = length(data);
        compCusum = zeros(1, sizie + 1);
        for j = 1:sizie
            compCusum(j + 1) = compCusum(j) + newData(j) - aver;
        end
        newDiff = max(compCusum) - min(compCusum);
        if newDiff < OGDiff
            notable = notable + 1;
        end
    end
    a = notable/bootstraps;
end

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
