%..mutation pop...
function child_pop = mutation_pop(pop)
pop_size = size(pop,1);
child_pop = zeros(size(pop));
for i = 1:pop_size
    child_pop(i,:) = mutate_ind(pop(i,:));
end
end


function child = mutate_ind(parent)
global opt
child = zeros(size(parent));
for j = 1:opt.n_var
    if rand() <= opt.p_mut
        y = parent(j);
        y_L = opt.L_bounds(j);
        y_U = opt.U_bounds(j);
        delta1 = (y-y_L)/(y_U - y_L);
        delta2 = (y_U - y)/(y_U - y_L);
        rand_no = rand();
        mut_pow = 1.0/(opt.eta_mut + 1);
        if rand_no <= 0.5
            xy = 1 - delta1;
            val = 2*rand_no + (1 - 2*rand_no)*(xy^(opt.eta_mut + 1));
            delta_q = val^(mut_pow) - 1;
        else
            xy = 1 - delta2;
            val = 2*(1 - rand_no) + 2*(rand_no - 0.5)*(xy^(1 + opt.eta_mut));
            delta_q = 1 - (val^mut_pow);
        end
        
        y = y + delta_q*(y_U - y_L);
        if(y < y_L)
            y = y_L;
        end
        if (y > y_U)
            y = y_U;
        end
        child(j) = y;
    else
        child(j) = parent(j);
    end
end
end