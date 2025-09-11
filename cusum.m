fprintf("Type the file name:");
fileName = input('', "s");
data = parseCSV(fileName);
sizie = size(data);
arraybian = [];
mucus(data, arraybian, sizie);

function mucus(data, arraybian, sizie)
    aver = mean(data);
    cusumData = 0;
    for(i = sizie(1):sizie(2))
        cusumData(i+1) = cusumData(i) + (data(i) - aver);
    end
    OGDiff = max(cusumData) - min(cusumData);
    if(bootstrap(data, OGDiff) > 0.95)
        mucus(data, arraybian, sizie(1), index(max(abs(cusumData))));
        mucus(data, arraybian, index(max(abs(cusumData))), sizie(2));
        arraybian = index(abs(max(cusumData)));
    end
    return;

end

