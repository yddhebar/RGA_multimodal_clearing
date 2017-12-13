%..best individual...
function [] = best_individual(pop)
global g_vars
global opt
[curr_best_fit,min_id] = min(pop(:,(opt.n_var + opt.n_cons + 1)));
curr_best = pop(min_id,:);
if curr_best_fit < g_vars.best_ind(opt.n_var + opt.n_cons + 1)
    g_vars.best_ind = curr_best;
end
end