% Training of SVM with the features extracted

clc;

tic
c = 1000;
lambda = 1e-7;
kerneloption = 1;
kernel = 'poly';
verbose = 0;
nbclass = 9;

%xapp feature matrix
%yapp group matrix

[xsup,w,b,nbsv] = svmmulticlassoneagainstone(traindata,train_res,nbclass,c,lambda,kernel,kerneloption,verbose);
%save('train_result.mat');

toc