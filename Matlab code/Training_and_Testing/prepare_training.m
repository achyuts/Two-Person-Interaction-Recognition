% Preparation of the training data

load activity_recog_boxing_training.mat
traindata= nf1';
clear nf1;

load activity_recog_drinking_training.mat
traindata=[traindata nf1'];
clear nf1;

load activity_recog_goodbye_training.mat
traindata=[traindata nf1'];
clear nf1;

load activity_recog_greeting_training.mat
traindata=[traindata nf1'];
clear nf1;

load activity_recog_handshake_training.mat
traindata=[traindata nf1'];
clear nf1;

load activity_recog_picking_training.mat
traindata=[traindata nf1'];
clear nf1;

load activity_recog_sitstand_training.mat
traindata=[traindata nf1'];
clear nf1;

load activity_recog_sittalk_training.mat
traindata=[traindata nf1'];
clear nf1;

load activity_recog_stationary_opp_training.mat
traindata=[traindata stationary_opp'];
clear nf1;

% load activity_recog_walking_training.mat
% traindata=[traindata nf1'];
% clear nf1;

traindata=traindata';

save('training_data.mat','traindata');

%load trainresult.mat