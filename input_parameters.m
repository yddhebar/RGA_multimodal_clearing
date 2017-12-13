%..input parameters...
function [opt] = input_parameters()
    opt.pop_size = 480;
    opt.max_gen = 20;
    opt.n_cons = 0;%..number of constraints...
    opt.n_var = 20;
    opt.L_bounds = -8*ones(opt.n_var,1);
    opt.U_bounds = 10*ones(opt.n_var,1);
    opt.p_xover = 0.9;
    opt.p_mut = 1/opt.n_var;
    opt.eta_xover = 2;
    opt.eta_mut = 15;
    opt.max_runs = 1;
    opt.prob_name = 'rastrigin';
    opt.radius = 0.01;
    opt.eps = 0.01;
    opt.n_desired_optima = 48;
    opt.optimum_fitness = 0.0;
end