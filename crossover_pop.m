%...cross_over_pop...
function child_pop = crossover_pop(parent_pop)
pop_size = size(parent_pop,1);
child_pop = zeros(size(parent_pop));
a_ids = 1:pop_size;
a1 = a_ids(randperm(pop_size));

if rem(pop_size,2) ~= 0
    i_o = 1;
    child_pop(pop_size) = parent_pop(a1(pop_size));
else
    i_o = 0;
end

for i = 1:2:(pop_size - i_o)
    [child_pop(i,:),child_pop(i+1,:)] = crossover(parent_pop(a1(i),:),parent_pop(a1(i+1),:));
end
end

function [child1,child2] = crossover(parent1,parent2)
global opt
global g_vars
child1 = zeros(size(parent1));
child2 = zeros(size(parent2));

if rand() <= opt.p_xover
    for i = 1:opt.n_var
        if rand() < 0.5
            if norm(parent1(i) - parent2(i)) >= g_vars.EPS
                if (parent1(i) < parent2(i))
                    y1 = parent1(i);
                    y2 = parent2(i);
                else
                    y1 = parent2(i);
                    y2 = parent1(i);
                end
                y_L = opt.L_bounds(i);
                y_U = opt.U_bounds(i);
                rand_no = rand();
                beta = 1.0 + (2.0*(y1 - y_L)/(y2 - y1));
                alpha = 2.0 - (beta^(-(opt.p_xover + 1)));
                if (rand_no <= 1/alpha)
                    beta_q = (rand_no*alpha)^(1/(opt.p_xover + 1));
                else
                    beta_q = (1/(2.0 - rand_no*alpha))^(1/(opt.p_xover + 1));
                end
                c1 = 0.5*((y1+y2) - beta_q*(y2-y1));
                
                beta = 1.0 + (2.0*(y_U-y2)/(y2-y1));
                alpha = 2.0 - (beta^(-(opt.p_xover + 1)));
                if (rand_no <= 1/alpha)
                    beta_q = (rand_no*alpha)^(1/(opt.p_xover + 1));
                else
                    beta_q = (1/(2.0 - rand_no*alpha))^(1/(opt.p_xover + 1));
                end
                c2 = 0.5*((y1+y2)+beta_q*(y2-y1));
                
                if (c1 < y_L)
                    c1 = y_L;
                end
                if (c2 < y_L)
                    c2 = y_L;
                end
                if(c1 > y_U)
                    c1 = y_U;
                end
                if(c2 > y_U)
                    c2 = y_U;
                end
                
                if rand() <= 0.5
                    child1(i) = c2;
                    child2(i) = c1;
                else
                    child1(i) = c1;
                    child2(i) = c2;
                end
            else
                child1(i) = parent1(i);
                child2(i) = parent2(i);
            end
        else
            child1(i) = parent1(i);
            child2(i) = parent2(i);
        end
    end
else
    child1(1:opt.n_var) = parent1(1:opt.n_var);
    child2(1:opt.n_var) = parent2(1:opt.n_var);
end
end