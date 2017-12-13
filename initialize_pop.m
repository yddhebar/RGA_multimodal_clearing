% ....initialization..
% ...inputs: pop_size = population size
% n_var = number of variables
% U_bounds = upper bound of variables
% L_bounds = Lower bound of variables
% n_cons = number of constraints
% Output:
%     initi_pop = size(pop_size,n_columns);
%     each row in init pop is an individual
%     each individual = [n_var, n_cons, fitness,cons_violation,min_dist_from_leader,c_id]

function init_pop = initialize_pop()
    global opt
    ind_size = opt.n_var + opt.n_cons + 1 + 1 + 1 + 1;
    init_pop = zeros(opt.pop_size,ind_size);
    for i = 1:opt.pop_size
        for j = 1:opt.n_var
            init_pop(i,j) = opt.L_bounds(j) + opt.U_bounds(j)*rand(1,1);
        end
    end
end