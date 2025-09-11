fprintf("Type the file name:");
fileName = input('', "s");
start = 0;
finish = 0;
data = parse_datafile(fileName);
arraybian = [];
mucus(arraybian, start, finish);

function mucus(data, arraybian, start, finish)
    aver = mean(data);
    cusumData = 0;
    for(i = start:finish)
        cusumData(i+1) = cusumData(i) + (data(i) - aver);
    end
    maxi = max(abs(cusumData));
    if(bootstrap(data) > 0.95)
        mucus(data, arraybian, start, index(max(abs(cusumData))));
        mucus(data, arraybian, index(max(abs(cusumData))), finish);
        arraybian = index(abs(max(cusumData)));
    end
    return;

end

