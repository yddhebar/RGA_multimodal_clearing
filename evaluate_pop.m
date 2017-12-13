% n_var = number of variables
% n_cons = number of constrains
%....feasible solutions have all constraints >= 0....
function evald_pop = evaluate_pop(pop)
    global opt
    pop_size = size(pop,1);
    evald_pop = pop;
    for i = 1:pop_size
        evald_pop(i,(opt.n_var+1):(opt.n_var + opt.n_cons + 2)) = evaluate_ind(pop(i,1:opt.n_var));
    end
end

%.. evald_ind = [n_cons,fitness,total_cons_violation]
function evald_ind = evaluate_ind(ind)
    global opt
    x = ind(1:opt.n_var);
    n_var = opt.n_var;
    evald_ind = zeros(1,opt.n_cons + 1 + 1);%...[constraints, fitness, cons_violation]
    
    switch opt.prob_name
        case 'sphere'
            func_value = dot(x,x);
            evald_ind(end - 1) = func_value;
        case 'rastrigin'
            Ax = dot(x,x);
            Bx = sum(cos(2*pi*x));
            func_value = 10*n_var + Ax - 10*Bx;
            evald_ind(end - 1) = func_value;
        otherwise
            disp('Problem not specified or coded')
    end

end