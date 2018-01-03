%...multimodal stats....
function optima_list = ListOfOptima(pop)
global opt

%...sort wrt obj...
fit_array = pop(:,opt.n_var + opt.n_cons + 1:opt.n_var + opt.n_cons + 2);
%cons_array = pop(opt.n_var + opt.n_cons + 2);

[sorted_fitness, sorted_fitness_id] = sortrows(fit_array,[2,1]);

Optim_id = zeros(size(sorted_fitness_id));
n_optima = 0;
if sorted_fitness(1,2) > 0
    optima_list = [];
    return
end
if abs(sorted_fitness(1,1) - opt.optimum_fitness) <= opt.eps
    Optim_id(1) = sorted_fitness_id(1);
    n_optima = 1;
else
    optima_list = [];
    return
end
for i = 2:size(pop,1)
    if sorted_fitness(i,2) > 0
        break
    end
    if (abs(sorted_fitness(i,1) - opt.optimum_fitness) <= opt.eps)
        p_id = sorted_fitness_id(i);
        new_optima = 1;
        for j = 1:n_optima
            opt_id = Optim_id(j);
            if norm(pop(opt_id,1:opt.n_var) - pop(p_id,1:opt.n_var)) <= opt.radius
                new_optima = 0;
                break
            end      
        end
        if new_optima == 1
            n_optima = n_optima + 1;
            Optim_id(n_optima) = p_id;
        end
    end
end
optima_list = pop(Optim_id(1:n_optima),:);
if n_optima > opt.n_desired_optima
    fprintf('here\n');
end
end