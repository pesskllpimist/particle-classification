clear
clc

%% Data Import
load('');
M = size(features,1);
%% Training set and test set
P_train = [];
T_train = [];
P_test = [];
T_test = [];

idx = randperm(M);
P_train = features(idx(1:0.95*M), :);
T_train = classes(idx(1:0.95*M), 1);
P_test = features( idx(0.95*M+1:end), :);
T_test = classes( idx(0.95*M+1:end), 1);

P_train = P_train.';
T_train = T_train.';
P_test = P_test.';
T_test = T_test.';


%% III. Modeling 
result_grnn = [];
result_pnn = [];
time_grnn = [];
time_pnn = [];

        p_train = P_train;
        p_test = P_test;

       %%

        t = cputime;
        Tc_train = ind2vec(T_train);

        net_pnn = newpnn(p_train,Tc_train);

        Tc_test = ind2vec(T_test);
        t_sim_pnn = sim(net_pnn,p_test);
        T_sim_pnn = vec2ind(t_sim_pnn);
        t = cputime - t;
        time_pnn = [time_pnn t];
        result_pnn = [result_pnn T_sim_pnn'];
 
%% IV Performance Evaluation
%% accuracy
time = [];
i = 1
accuracy_pnn = length(find(result_pnn(:,i) == T_test'))/length(T_test);


result = [T_test' result_pnn]
accuracy = accuracy_pnn
time = time_pnn
%% V. Plot
figure(1)
plot(1:100,T_test,'bo',1:100,result_pnn,'k:^')
grid on
xlabel('Test set sample number')
ylabel('Test set sample categories')
string = {'PNN';['Accuracy:' num2str(accuracy_pnn*100) '%']};
title(string)
legend('True Value','Predicted value')


YTest = categorical(T_test);
YPred = categorical(result_pnn);
YPred = YPred.';
confusionchart(YTest,YPred,"RowSummary","row-normalized");
title("Accuary:"+accuracy_pnn*100+"%")
xlabel('Pred')
ylabel('True')





