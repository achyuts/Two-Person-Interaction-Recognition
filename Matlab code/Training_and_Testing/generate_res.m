% Utility to prepare the training testing data

i1= ones(1,1000);
i2= ones(1,694).*2;
i3= ones(1,543).*3;
i4= ones(1,1000).*4;
i5= ones(1,1000).*5;
i6= ones(1,686).*6;
i7= ones(1,400).*7;
i8= ones(1,1072).*8;
i9= ones(1,511).*9;
%i10= ones(1,401).*10;

train_res=[i1 i2 i3 i4 i5 i6 i7 i8 i9 ]';

save('train_res.mat','train_res');
