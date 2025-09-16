function a = bootstrap(data, OGDiff, aver, bootstraps)
    notable = 0;
    for i = 1:bootstraps
        newData = data(randperm(length(data)));
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