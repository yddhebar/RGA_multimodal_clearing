%...plot results....
clear all
close all
clc
prob_name = 'schwefel'
ori_data = load(strcat('results/',prob_name,'_pure_rga.txt'));
eta100_data = load(strcat('results/',prob_name,'_eta100_rga.txt'));
eta100L_data = load(strcat('results/',prob_name,'_eta100L_rga.txt'));
eta_adaptive_data = load(strcat('results/',prob_name,'_eta_adaptive_rga.txt'));

gen = ori_data(:,1);
set(groot,'defaultLineLineWidth',2)
figure(1)
semilogy(gen,ori_data(:,2),'k');
hold on
semilogy(gen,ori_data(:,4),'--k');
semilogy(gen,eta100L_data(:,2),'g');
semilogy(gen,eta100L_data(:,4),'--g');
semilogy(gen,eta100_data(:,2),'r');
semilogy(gen,eta100_data(:,4),'--r');
semilogy(gen,eta_adaptive_data(:,2),'-b');
semilogy(gen,eta_adaptive_data(:,4),'--b');
plot(gen,eta_adaptive_data(:,5),'-.b');
xlabel('Generations');
ylabel('Fitness');
title(prob_name);
legend('normal','std-dev','push = linear', 'std','push = 1.0','std-dev', 'push = adaptive','std-dev','eta');
set(gca,'fontsize',20)
hold off

figure(3)
plot(gen,eta_adaptive_data(:,5),'-.b');
title(prob_name);
legend('eta');
xlabel('gen');
ylabel('eta');


%..plot standard deviations....
std_dev_data = load(strcat('results/',prob_name,'_std_dev.txt'));


std_xover = std_dev_data(:,1);
std_mut = std_dev_data(:,2);
std_push = std_dev_data(:,3);
gen = gen(2:end);
figure(2)
semilogy(gen,std_xover,'--k');
hold on
semilogy(gen,std_mut,'--b');
semilogy(gen,std_push,'--r');
xlabel('Generations');
ylabel('Diversity');
title(prob_name);
legend('X-over','Mutation','Push');
set(gca,'fontsize',20)
