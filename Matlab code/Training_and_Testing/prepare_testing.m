% Preparation of the testing data

load activity_recog_boxing_testing.mat
testdata= nf1';
clear nf1;

load activity_recog_drinking_testing.mat
testdata=[testdata nf1'];
clear nf1;

load activity_recog_goodbye_testing.mat
testdata=[testdata nf1'];
clear nf1;

load activity_recog_greeting_testing.mat
testdata=[testdata nf1'];
clear nf1;

load activity_recog_handshake_testing.mat
testdata=[testdata nf1'];
clear nf1;

load activity_recog_picking_testing.mat
testdata=[testdata nf1'];
clear nf1;

load activity_recog_sitstand_testing.mat
testdata=[testdata nf1'];
clear nf1;

load activity_recog_sittalk_testing.mat
testdata=[testdata nf1'];
clear nf1;

load activity_recog_stationary_opp_testing.mat
testdata=[testdata nf1'];
clear nf1;

% load activity_recog_walking_testing.mat
% testdata=[testdata nf1'];
% clear nf1;

testdata=testdata';

save('testing_data.mat','testdata');

%load testresult.mat