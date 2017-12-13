%....non_uniform_push
function pushed_pop = push_pop(pop,sink,gen)
pushed_pop = pop;
pop_size = size(pop,1);
eta_push = 0.01*gen;
for i = 1:pop_size
    pushed_pop(i,:) = push_ind(pop(i,:),sink,eta_push);
end
end

function pushed_ind = push_ind(ind,sink,eta)
global opt
global g_vars
pushed_ind = ind;
for j = 1:opt.n_var
    a = opt.L_bounds(j);
    b = opt.U_bounds(j);
    x = ind(j);
    x_b = sink(j);
    x_pushed = x;
    if abs(x - x_b) >= g_vars.EPS
        if (x < x_b) && (x > a)
            x_pushed = a + ((x - a)*(x_b - a)^eta)^(1/(1+eta));
        elseif (x > x_b) && (x < b)
            x_pushed = b - ((b - x)*(b - x_b)^eta)^(1/(1+eta));
        end
        
        if x_pushed < a
            x_pushed = a;
        elseif x_pushed > b
            x_pushed = b;
        end
    end
    pushed_ind(j) = x_pushed;
end

end