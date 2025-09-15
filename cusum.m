fprintf("Type the file name:");
fileName = input('', "s");
fprintf("What is your desired confidence interval?");
confidence = input('');
fprintf("What is the number of bootstraps?");
bootstraps = input('');
data = parseCSV(fileName);
%sizie = size(data);
arraybian = [];
mucus(data, arraybian, sizie, confidence, 1);

function [arraybian] = mucus(data, arraybian, confidence, iteration)
    hold on;
    plot(data);
    aver = mean(data);
    cusumData = 0;
    sizie = size(data);
    for(i = sizie(1):sizie(2))
        cusumData(i+1) = cusumData(i) + (data(i) - aver);
    end
    plot(cusumData);
    OGDiff = max(cusumData) - min(cusumData);
    if(bootstrap(data, OGDiff) > confidence)
        mucus(data(sizie(1)):data(index(max(abs(cusumData)))), arraybian, confidence, size(arraybian)+1);
        mucus(data(index(max(abs(cusumData)))):data(sizie(2)), arraybian, confidence, size(arraybian)+2);
        arraybian(iteration) = index(abs(max(cusumData)));
    end
    return;

end

