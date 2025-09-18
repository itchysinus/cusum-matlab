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
% 
function changepoints = mucus(data, confidence, bootstraps, start)
    changepoints = [];
    aver = mean(data);
    sizie = length(data);
    cusumData = zeros(1, sizie + 1);
    for i = 1:sizie
        cusumData(i+1) = cusumData(i) + (data(i) - aver);
    end
    
    OGDiff = max(cusumData) - min(cusumData);
    if(bootstrap(data, OGDiff, aver, bootstraps) > confidence)
        x_vals = start + (1:sizie + 1);
        plot(x_vals, cusumData, '*r');
        [~, idx] = max(abs(cusumData));
        cp = idx - 1;
        left = mucus(data(1:cp), confidence, bootstraps, start);
        right = mucus(data(cp:end), confidence, bootstraps, cp);
        right = right + cp;
        changepoints = [left, cp, right];
    end
    return;

end

