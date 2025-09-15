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
arraybian = [];
hold on;
plot(data);
mucus(data, arraybian, confidence, 1, bootstraps);

function arraybian = mucus(data, arraybian, confidence, iteration, bootstraps)
    aver = mean(data);
    sizie = length(data);
    cusumData = zeros(1, sizie + 1);
    for i = 1:sizie
        cusumData(i+1) = cusumData(i) + (data(i) - aver);
    end
    plot(cusumData);
    OGDiff = max(cusumData) - min(cusumData);
    if(bootstrap(data, OGDiff, aver, bootstraps) > confidence)
        mucus(data(1:find(abs(cusumData)==max(abs(cusumData)))), arraybian, confidence, length(arraybian)+1, bootstraps);
        mucus(data(find(abs(cusumData)==max(abs(cusumData))):sizie), arraybian, confidence, length(arraybian)+2, bootstraps);
        arraybian(iteration) = find(abs(cusumData)==max(abs(cusumData)));
    end
    return;

end

