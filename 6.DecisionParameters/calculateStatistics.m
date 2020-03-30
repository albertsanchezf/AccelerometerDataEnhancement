function [allMeans,allVar,allStd,allMedian,allMax,allMin,...
    sma,svm,svmMeans,svmVar,svmStd] = calculateStatistics(allMeans,...
    allVar,allStd,allMedian,allMax,allMin,sma,svmMeans,svmVar,svmStd,x,y,z)

    allMeans{1,1}        = [allMeans{1,1}, mean(x)];
    allMeans{2,1}        = [allMeans{2,1}, mean(mean(x))];
    allVar{1,1}          = [allVar{1,1}, var(x)];
    allVar{2,1}          = [allVar{2,1}, mean(var(x))];
    allStd{1,1}          = [allStd{1,1}, std(x)]; 
    allStd{2,1}          = [allStd{2,1}, mean(std(x))]; 
    allMedian{1,1}       = [allMedian{1,1}, median(x)];
    allMedian{2,1}       = [allMedian{2,1}, mean(median(x))];
    allMax{1,1}          = [allMax{1,1}, max(x)];
    allMax{2,1}          = [allMax{2,1}, mean(max(x))];
    allMin{1,1}          = [allMin{1,1}, min(x)];
    allMin{2,1}          = [allMin{2,1}, mean(min(x))];
    
    allMeans{1,2}        = [allMeans{1,2}, mean(y)];
    allMeans{2,2}        = [allMeans{2,2}, mean(mean(y))];
    allVar{1,2}          = [allVar{1,2}, var(y)];
    allVar{2,2}          = [allVar{2,2}, mean(var(y))];
    allStd{1,2}          = [allStd{1,2}, std(y)];    
    allStd{2,2}          = [allStd{2,2}, mean(std(y))]; 
    allMedian{1,2}       = [allMedian{1,2}, median(y)];
    allMedian{2,2}       = [allMedian{2,2}, mean(median(y))];
    allMax{1,2}          = [allMax{1,2}, max(y)];
    allMax{2,2}          = [allMax{2,2}, mean(max(y))];
    allMin{1,2}          = [allMin{1,2}, min(y)];
    allMin{2,2}          = [allMin{2,2}, mean(min(y))];
    
    allMeans{1,3}        = [allMeans{1,3}, mean(z)];
    allMeans{2,3}        = [allMeans{2,3}, mean(mean(z))];
    allVar{1,3}          = [allVar{1,3}, var(z)];
    allVar{2,3}          = [allVar{2,3}, mean(var(z))];
    allStd{1,3}          = [allStd{1,3}, std(z)];    
    allStd{2,3}          = [allStd{2,3}, mean(std(z))]; 
    allMedian{1,3}       = [allMedian{1,3}, median(z)];
    allMedian{2,3}       = [allMedian{2,3}, mean(median(z))];
    allMax{1,3}          = [allMax{1,3}, max(z)];
    allMax{2,3}          = [allMax{2,3}, mean(max(z))];
    allMin{1,3}          = [allMin{1,3}, min(z)];
    allMin{2,3}          = [allMin{2,3}, mean(min(z))];
    
    sma{1}               = [sma{1}, smaAcc(x,y,z)];
    sma{2}               = [sma{2}, mean(smaAcc(x,y,z))];
    svm                  = svmAcc(x,y,z);
    svmMeans{1}          = [svmMeans{1}, mean(svm)];
    svmMeans{2}          = [svmMeans{2}, mean(mean(svm))];
    svmVar{1}            = [svmVar{1}, var(svm)];
    svmVar{2}            = [svmVar{2}, mean(var(svm))];
    svmStd{1}            = [svmStd{1}, std(svm)];    
    svmStd{2}            = [svmStd{2}, mean(std(svm))];    

end

