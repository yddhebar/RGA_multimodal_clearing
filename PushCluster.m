%...push cluster..
function child_pop = PushCluster(pop,gen)
global opt g_vars
c_id_index = opt.n_var + opt.n_cons + 2 + 2;
n_clusters = size(g_vars.LeadersArchive,1);
child_pop = pop;
for c_id = 1:n_clusters
    sub_pop_id = pop(:,c_id_index) == c_id;
    sub_pop = pop(sub_pop_id,:);
    if isempty(sub_pop) == 0
        pushed_sub_pop = push_pop(sub_pop,g_vars.LeadersArchive(c_id,:),gen);
        child_pop(sub_pop_id,:) = pushed_sub_pop;
    end
    
end
end