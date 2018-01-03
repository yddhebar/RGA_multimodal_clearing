%....ClusterAssignment...
%..input = population
%..output = population with its individuals now assigned with a cluster id
function clustered_pop = ClusterAssignment(pop)
global opt g_vars
LeadersArchive = g_vars.LeadersArchive;
n_leaders = size(LeadersArchive,1);
pop_size = size(pop,1);
sigma_share = g_vars.sigma_share;
range_array = g_vars.nf;%opt.U_bounds - opt.L_bounds;
c_id_index = opt.n_var + opt.n_cons + 2 + 2;
for i = 1:pop_size
    dist_matrix = repmat(pop(i,1:opt.n_var),[n_leaders,1]) - LeadersArchive(:,1:opt.n_var);
    norm_dist_matrix = (dist_matrix./repmat(range_array',[n_leaders,1]));
    norm_dist_array = sqrt(sum(norm_dist_matrix.^2,2));
    [min_dist, c_id] = min(norm_dist_array);
    if min_dist <= sigma_share
        pop(i,c_id_index) = c_id;
    else
        pop(i,c_id_index) = 0;
    end
    pop(i,c_id_index-1) = min_dist;
end
clustered_pop = pop;
end