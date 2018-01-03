%..input parameters...
function [opt] = input_parameters() 
    prob_name = 'CMMP_10_16_0';
    opt = problem_input(prob_name);
end

function [opt] = problem_input(prob_name)
switch prob_name
    case 'equal_maxima'
        opt.prob_name = 'equal_maxima';
        opt.pop_size = 50;
        opt.max_gen = 1000;
        opt.n_cons = 0;%..number of constraints...
        opt.n_var = 1;
        opt.L_bounds = 0*ones(opt.n_var,1);
        opt.U_bounds = 1*ones(opt.n_var,1);
        opt.p_xover = 0.9;
        opt.p_mut = 0.1;%1/opt.n_var;
        opt.eta_xover = 20;
        opt.eta_mut = 15;
        opt.max_runs = 50;  
        opt.radius = 0.01;
        opt.eps = 0.01;
        opt.n_desired_optima = 5;
        opt.optimum_fitness = -1.0;
        
    case 'himmelblau'
        opt.prob_name = 'himmelblau';
        opt.pop_size = 100;
        opt.max_gen = 500;
        opt.n_cons = 0;%..number of constraints...
        opt.n_var = 2;
        opt.L_bounds = -6*ones(opt.n_var,1);
        opt.U_bounds = 6*ones(opt.n_var,1);
        opt.p_xover = 0.9;
        opt.p_mut = 0.1;%1/opt.n_var;
        opt.eta_xover = 20;
        opt.eta_mut = 15;
        opt.max_runs = 50;  
        opt.radius = 0.05;
        opt.eps = 0.01;
        opt.n_desired_optima = 4;
        opt.optimum_fitness = -200.0;
    case 'six_hump_camel'
        opt.prob_name = 'six_hump_camel';
        opt.pop_size = 100;
        opt.max_gen = 500;
        opt.n_cons = 0;
        opt.n_var = 2;
        opt.L_bounds = [-1.9;-1.1];
        opt.U_bounds = [1.9;1.1];
        opt.p_xover = 0.9;
        opt.p_mut = 0.1;%1/opt.n_var;
        opt.eta_xover = 20;
        opt.eta_mut = 15;
        opt.max_runs = 50;  
        opt.radius = 0.5;
        opt.eps = 0.01;
        opt.n_desired_optima = 2;
        opt.optimum_fitness = -1.03163;
        
    case 'modified_rastrigin'
        opt.prob_name = 'modified_rastrigin';
        opt.pop_size = 100;
        opt.max_gen = 2000;
        opt.n_cons = 0;%..number of constraints...
        opt.n_var = 2;
        opt.L_bounds = 0*ones(opt.n_var,1);
        opt.U_bounds = 1*ones(opt.n_var,1);
        opt.p_xover = 0.9;
        opt.p_mut = 0.1;%1/opt.n_var;
        opt.eta_xover = 20;
        opt.eta_mut = 15;
        opt.max_runs = 1;  
        opt.radius = 0.01;
        opt.eps = 0.01;
        opt.n_desired_optima = 12;
        opt.optimum_fitness = 2;
        
    case 'modified_rastrigin_16D'
        opt.prob_name = 'modified_rastrigin_16D';
        opt.pop_size = 480;
        opt.max_gen = 1000;
        opt.n_cons = 0;%..number of constraints...
        opt.n_var = 16;
        opt.L_bounds = 0*ones(opt.n_var,1);
        opt.U_bounds = 1*ones(opt.n_var,1);
        opt.p_xover = 0.9;
        opt.p_mut = 1/opt.n_var;
        opt.eta_xover = 20;
        opt.eta_mut = 15;
        opt.max_runs = 1;  
        opt.radius = 0.05;
        opt.eps = 0.01;
        opt.n_desired_optima = 48;
        opt.optimum_fitness = 16;
        
    case 'CMMP_2_4_0'
        opt.prob_name = 'CMMP_2_4_0';
        opt.pop_size = 100;
        opt.max_gen = 500;
        opt.n_cons = 2;%..number of constraints...
        opt.n_var = 2;
        opt.L_bounds = -3*ones(opt.n_var,1);
        opt.U_bounds = 3*ones(opt.n_var,1);
        opt.p_xover = 0.9;
        opt.p_mut = 0.1;
        opt.eta_xover = 20;
        opt.eta_mut = 15;
        opt.max_runs = 50;  
        opt.radius = 0.05;
        opt.eps = 0.01;
        opt.n_desired_optima = 4;
        opt.optimum_fitness = 1.6;
        
    case 'CMMP_10_16_0'
        opt.prob_name = 'CMMP_10_16_0';
        opt.pop_size = 250;
        opt.max_gen = 2500;
        opt.n_cons = 4;%..number of constraints...
        opt.n_var = 10;
        opt.L_bounds = -11*ones(opt.n_var,1);
        opt.U_bounds = 11*ones(opt.n_var,1);
        opt.p_xover = 0.9;
        opt.p_mut = 0.1;
        opt.eta_xover = 20;
        opt.eta_mut = 15;
        opt.max_runs = 1;  
        opt.radius = 0.2;
        opt.eps = 0.01;
        opt.n_desired_optima = 16;
        opt.optimum_fitness = 1.6081;
end
end