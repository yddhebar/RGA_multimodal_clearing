%....rga code..
%...Developed by Yashesh Dhebar......
clear all
close all
clc

%...Parameters...
global opt g_vars
opt = input_parameters();
g_vars = global_vars();


for run = 1:opt.max_runs
    fprintf('run = %d\n',run);
    rng(run,'twister');%..seeding the random number generator..
    best_value = zeros(opt.max_gen,1);
    parent_pop = initialize_pop();
    parent_pop = evaluate_pop(parent_pop);
    [best_value(1),min_id] = min(parent_pop(:,(opt.n_var + opt.n_cons + 1)));
    g_vars.best_ind = parent_pop(min_id,:);
    
    for gen = 1:opt.max_gen
        fprintf('gen = %d',gen);
        LeadersSelection(parent_pop);
        parent_pop = ClusterAssignment(parent_pop);
        child_pop = LocalizedSelection(parent_pop);
        child_pop = crossover_pop(child_pop);
        child_pop = mutation_pop(child_pop);
        child_pop = ClusterAssignment(child_pop);
        child_pop = evaluate_pop(child_pop);
        parent_pop = LeadersPreservation(child_pop);
        best_individual(parent_pop);
        best_value(gen + 1) = g_vars.best_ind(opt.n_var + opt.n_cons + 1);
        fprintf('\t best_value = %f\n',best_value(gen+1));
    end
end

all_gens = [0:opt.max_gen]';
semilogy(all_gens,best_value);
title(opt.prob_name);
xlabel('Generation');
ylabel('Best Fitness');


