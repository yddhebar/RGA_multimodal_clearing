%...Leaders Selection via Clearing Algorithm....
function [] = LeadersSelection(pop,gen)
global opt g_vars
n_var = opt.n_var;
pop_size = opt.pop_size;
g_vars.sigma_share = 0.5/(opt.n_desired_optima^(1/opt.n_var));
sigma_share = g_vars.sigma_share;
max_leaders = 2*opt.n_desired_optima;
%..compute normalizing factors...
compute_norm_factors(pop,gen);

%...Applying Clearing Algorithm...
WSI = zeros(size(pop));
fitness_array = pop(:,(opt.n_var + opt.n_cons +1):(opt.n_var + opt.n_cons + 2));
%...sorting first wrt to cons violation and then wrt fitness...
[sorted_fit_array, sorted_fit_id] = sortrows(fitness_array,[2,1]);

n_leaders = 1;
WSI(1,:) = pop(sorted_fit_id(1),:);
c_id_index = opt.n_var + opt.n_cons + 2 + 2;
WSI(1,c_id_index) = 1;

for i = 1:pop_size
    if n_leaders >= max_leaders
        break;
    end
    new_leader = 1;
    for j = 1:n_leaders
        dist = normalized_dist_btw_ind(pop(sorted_fit_id(i),:),WSI(j,:));
        if dist <= sigma_share
            new_leader = 0;
            break;
        end
    end
    if new_leader == 1
        n_leaders = n_leaders + 1;
        WSI(n_leaders,:) = pop(sorted_fit_id(i),:);
        WSI(n_leaders,c_id_index) = n_leaders;
    end
end
g_vars.WSI = WSI;%(1:n_leaders,:);
if n_leaders > max_leaders
    n_leaders = max_leaders;
end
g_vars.LeadersArchive = WSI(1:n_leaders,:);

end

function compute_norm_factors(pop,gen)
global g_vars opt
nf1 = opt.U_bounds - opt.L_bounds;
if gen == 1
    g_vars.nf = nf1;
else
    %X = pop(:,1:opt.n_var);
    X = g_vars.WSI(:,1:opt.n_var);
    stdX = 2*max(std(X))*ones(1,opt.n_var);
    nfa = [stdX;nf1'];
    nf = min(nfa);
    g_vars.nf = nf';
    %g_vars.nf = std(X)';
end
%g_vars.nf = nf1;
end

function norm_dist = normalized_dist_btw_ind(ind1,ind2)
global opt g_vars
range_array = g_vars.nf;%opt.U_bounds - opt.L_bounds;
dist_vec = ind1(1:opt.n_var) - ind2(1:opt.n_var);
norm_dist = norm(dist_vec'./range_array);
end