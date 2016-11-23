% Utility to calculate the total accuracy

function [accuracy] = calculate_the_overall_accuracy(test_res, ypred)

    dif = test_res - ypred;
    [lr, lc] = find(dif);
    [wrong, misc] = size(lr);

    [test_set, tc] = size(test_res);
    correct = test_set - wrong;

    test_set
    correct
    wrong

    accuracy = correct / test_set;
    accuracy = accuracy * 100;
    accuracy    
end