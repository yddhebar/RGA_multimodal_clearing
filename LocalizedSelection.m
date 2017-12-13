%..Localized Selection....
function child_pop = LocalizedSelection(pop)
global opt g_vars
cluster_id_array = pop(:,opt.n_var + opt.n_cons + 2 + 2);
child_pop = [];%zeros(size(pop));
n_indivs = 0;
for c_id = 0:max(cluster_id_array)
    sub_pop_ids = cluster_id_array == c_id;
    sub_pop = pop(sub_pop_ids,:);
    if isempty(sub_pop)
        continue
    end
    sub_pop_sel = selection(sub_pop);
    %child_pop((n_indivs+1):(n_indivs + size(sub_pop_sel,1)),:) = sub_pop_sel;
    child_pop = [child_pop;sub_pop_sel];
    n_indivs = size(child_pop,1);
end
end