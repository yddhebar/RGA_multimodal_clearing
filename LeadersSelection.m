%...Leaders Selection via Clearing Algorithm....
function [] = LeadersSelection(pop)
global opt g_vars
n_var = opt.n_var;
pop_size = opt.pop_size;
g_vars.sigma_share = 0.5/(opt.n_desired_optima^(1/opt.n_var));
sigma_share = g_vars.sigma_share;
max_leaders = 2*opt.n_desired_optima;

%...Applying Clearing Algorithm...
LeadersArchive = zeros(size(pop));
fitness_array = pop(:,(opt.n_var+1):(opt.n_var+2));
%...sorting first wrt to cons violation and then wrt fitness...
[sorted_fit_array, sorted_fit_id] = sortrows(fitness_array,[2,1]);

n_leaders = 1;
LeadersArchive(1,:) = pop(sorted_fit_id(1),:);
c_id_index = opt.n_var + opt.n_cons + 2 + 2;
LeadersArchive(1,c_id_index) = 1;

for i = 1:pop_size
    if n_leaders >= max_leaders
        break;
    end
    new_leader = 1;
    for j = 1:n_leaders
        dist = normalized_dist_btw_ind(pop(sorted_fit_id(i),:),LeadersArchive(j,:));
        if dist <= sigma_share
            new_leader = 0;
            break;
        end
    end
    if new_leader == 1
        n_leaders = n_leaders + 1;
        LeadersArchive(n_leaders,:) = pop(sorted_fit_id(i),:);
        LeadersArchive(n_leaders,c_id_index) = n_leaders;
    end
end

g_vars.LeadersArchive = LeadersArchive(1:n_leaders,:);
end

function norm_dist = normalized_dist_btw_ind(ind1,ind2)
global opt
range_array = opt.U_bounds - opt.L_bounds;
dist_vec = ind1(1:opt.n_var) - ind2(1:opt.n_var);
norm_dist = norm(dist_vec'./range_array);
end