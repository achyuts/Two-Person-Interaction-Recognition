%Utility to calculate the accuracy of each interaction

i1= ones(500,1);
i2= ones(385,1).*2;
i3= ones(445,1).*3;
i4= ones(500,1).*4;
i5= ones(500,1).*5;
i6= ones(313,1).*6;
i7= ones(301,1).*7;
i8= ones(724,1).*8;
i9= ones(400,1).*9;


r1=ypred(1:500,1);
r2=ypred(501:885,1);
r3=ypred(886:1330,1);
r4=ypred(1331:1830,1);
r5=ypred(1831:2330,1);
r6=ypred(2331:2643,1);
r7=ypred(2644:2944,1);
r8=ypred(2945:3668,1);
r9=ypred(3669:4068,1);


dif=i1-r1;
[lr lc]=find(dif);
[wrong misc]=size(lr);

[test_set tc]=size(i1);
correct=test_set-wrong;

test_set
correct
wrong

accuracy=correct/test_set;
accuracy=accuracy*100;
accuracy

dif=i2-r2;
[lr lc]=find(dif);
[wrong misc]=size(lr);

[test_set tc]=size(i2);
correct=test_set-wrong;

test_set
correct
wrong

accuracy=correct/test_set;
accuracy=accuracy*100;
accuracy

dif=i3-r3;
[lr lc]=find(dif);
[wrong misc]=size(lr);

[test_set tc]=size(i3);
correct=test_set-wrong;

test_set
correct
wrong

accuracy=correct/test_set;
accuracy=accuracy*100;
accuracy

dif=i4-r4;
[lr lc]=find(dif);
[wrong misc]=size(lr);

[test_set tc]=size(i4);
correct=test_set-wrong;

test_set
correct
wrong

accuracy=correct/test_set;
accuracy=accuracy*100;
accuracy

dif=i5-r5;
[lr lc]=find(dif);
[wrong misc]=size(lr);

[test_set tc]=size(i5);
correct=test_set-wrong;

test_set
correct
wrong

accuracy=correct/test_set;
accuracy=accuracy*100;
accuracy


dif=i6-r6;
[lr lc]=find(dif);
[wrong misc]=size(lr);

[test_set tc]=size(i6);
correct=test_set-wrong;

test_set
correct
wrong

accuracy=correct/test_set;
accuracy=accuracy*100;
accuracy


dif=i7-r7;
[lr lc]=find(dif);
[wrong misc]=size(lr);

[test_set tc]=size(i7);
correct=test_set-wrong;

test_set
correct
wrong

accuracy=correct/test_set;
accuracy=accuracy*100;
accuracy


dif=i8-r8;
[lr lc]=find(dif);
[wrong misc]=size(lr);

[test_set tc]=size(i8);
correct=test_set-wrong;

test_set
correct
wrong

accuracy=correct/test_set;
accuracy=accuracy*100;
accuracy


dif=i9-r9;
[lr lc]=find(dif);
[wrong misc]=size(lr);

[test_set tc]=size(i9);
correct=test_set-wrong;

test_set
correct
wrong

accuracy=correct/test_set;
accuracy=accuracy*100;
accuracy


%test_res=[i1 i2 i3 i4 i5 i6 i7 i8 i9 i10]';
%clear i1 i2 i3 i4 i5 i6 i7 i8 i9 i10

%save('test_res.mat','test_res');
