fprintf("Type the file name:");
fileName = input('', "s");
fprintf("What is your desired confidence interval?");
confidence = input('');
while confidence < 0
    fprintf("Uh oh. That's going to be a problem. Please give a new confidence interval.");
    confidence = input('');
end
fprintf("What is the number of bootstraps?");
bootstraps = input('');
data = parseCSV(fileName);
hold on;
yyaxis right;
plot(data, 'Color', [0,0.9,0.9,0.1]);
yyaxis left;
changepoints = mucus(data, confidence, bootstraps, 0);
for i = 1:length(changepoints)
    fprintf("Changepoint %d: %d\n", i, changepoints(i));
end

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

