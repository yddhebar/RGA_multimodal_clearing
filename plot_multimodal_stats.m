%..plot multimodal...
clear all
close all
clc

prob_name = 'modified_rastrigin'
file_name = strcat('results/',prob_name,'_pure_rga.txt');
data = load(file_name);

gens = data(:,1);
n_clusters = data(:,end-1);
n_optima = data(:,end);

plot(gens,n_clusters,'*');
hold on
plot(gens,n_optima,'+');
legend('n clusters', 'n optima reached');
xlabel('gen')
title('modified_rastrigin');
