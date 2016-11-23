% Testing of new frames class

c = 1000;
lambda = 1e-7;
kerneloption= 1;
kernel='poly';
verbose = 0;
nbclass=9;
%xtest feature matrix

[ypred,maxi] = svmmultivaloneagainstone(testdata,xsup,w,b,nbsv,kernel,kerneloption);
%save('test_result.mat');