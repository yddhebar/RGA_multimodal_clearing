%...Selection Routine..
function sel_pop = selection(pop)
    global opt
    pop_size = size(pop,1);%..number of rows is the population size
    
    %...initiating shuffled arrays...
    a_ids = 1:pop_size;
    a1 = a_ids(randperm(pop_size));
    a2 = a_ids(randperm(pop_size));
    
    sel_pop = zeros(size(pop));
    
    for i = 1:pop_size
        sel_pop(i,:) = tourselect(pop(a1(i),:),pop(a2(i),:));
    end
end

function sel_ind = tourselect(ind1,ind2)
    global opt
    main_len = opt.n_var + opt.n_cons + 2;
    if (ind1(main_len) == 0) && (ind2(main_len) == 0) %.. both are feasible
        if ind1(main_len - 1) <= ind2(main_len - 1)
            sel_ind = ind1;
        else
            sel_ind = ind2;
        end
    elseif (ind1(main_len) > 0) && (ind2(main_len) == 0)
            sel_ind = ind2;
    elseif (ind1(main_len) == 0) && (ind2(main_len) > 0)
            sel_ind = ind1;
    else %... both are infeasible...
        if ind1(main_len) < ind2(main_len)
            sel_ind = ind1;
        elseif ind2(main_len) < ind1(main_len)
            sel_ind = ind2;
        else
            r = rand(1,1);
            if r < 0.5
                sel_ind = ind1;
            else
                sel_ind = ind2;
            end
        end
    end
end
