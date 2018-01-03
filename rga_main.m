%....rga code..
%...Developed by Yashesh Dhebar......
clear all
close all
clc

%...Parameters...
global opt g_vars
opt = input_parameters();
g_vars = global_vars();
peak_ratio_runs = zeros(opt.max_runs,1);
func_evals_runs = zeros(opt.max_runs,1);

for run = 1:opt.max_runs
    fprintf('run = %d\n',run);
    rng(run,'twister');%..seeding the random number generator..
    n_optima_gen = zeros(opt.max_gen,1);
    n_leaders_gen = zeros(opt.max_gen,1);
    parent_pop = initialize_pop();
    parent_pop = evaluate_pop(parent_pop);
    [best_value(1),min_id] = min(parent_pop(:,(opt.n_var + opt.n_cons + 1)));
    g_vars.best_ind = parent_pop(min_id,:);
    
    for gen = 1:opt.max_gen
        fprintf('gen = %d',gen);
        LeadersSelection(parent_pop,gen);
        n_leaders_gen(gen) = size(g_vars.LeadersArchive,1);
        parent_pop = ClusterAssignment(parent_pop);
        child_pop = LocalizedSelection(parent_pop);
        child_pop = crossover_pop(child_pop);
        child_pop = mutation_pop(child_pop);
        child_pop = ClusterAssignment(child_pop);
        child_pop = PushCluster(child_pop,gen);
        child_pop = evaluate_pop(child_pop);
        parent_pop = LeadersPreservation(child_pop);
        best_individual(parent_pop);
        optima_list = ListOfOptima(parent_pop);
        n_optima_gen(gen) = size(optima_list,1);
        fprintf('\t n_optima = %d \n',n_optima_gen(gen));
        if n_optima_gen(gen) == opt.n_desired_optima
            break
        end
    end
    func_evals_runs(run) = opt.pop_size*gen;
    optima_list = ListOfOptima(parent_pop);
    n_optima = size(optima_list,1);
    peak_ratio_runs(run) = n_optima;
end
report(parent_pop);
peak_ratio = sum(peak_ratio_runs)/(opt.n_desired_optima*opt.max_runs);
fprintf('\nPeak Ratio = %d\n',peak_ratio);

success_arr = peak_ratio_runs == opt.n_desired_optima;
fe_success_rus = func_evals_runs(success_arr);
peak_ratio_failed_runs = peak_ratio_runs(~success_arr);

fprintf('\t min \t mean \t med \t max\n')
fprintf('%d \t FEs %d \t %.2f \t %d \t %d\n',length(fe_success_rus),min(fe_success_rus),mean(fe_success_rus),...
    median(fe_success_rus),max(fe_success_rus))
fprintf('%d \t #peaks: %d \t %.2f \t %d \t %d\n',length(peak_ratio_failed_runs),min(peak_ratio_failed_runs),...
    mean(peak_ratio_failed_runs), median(peak_ratio_failed_runs), max(peak_ratio_failed_runs))
all_gens = [1:gen]';
figure(2)
plot(all_gens,n_leaders_gen(1:gen),'+');
hold on
plot(all_gens,n_optima_gen(1:gen),'*');
legend('n leaders','n optima');
hold off


