%...LeadersPreservation....
function elite_pop = LeadersPreservation(pop)
elite_pop = LeadersPreservation_updated(pop);
%elite_pop = LeadersPreservation_naive(pop);
end

function elite_pop = LeadersPreservation_updated(pop)
global opt g_vars
merged_pop = [g_vars.LeadersArchive;pop];
c_id_index = opt.n_var + opt.n_cons + 2 + 2;

n_clusters = size(g_vars.LeadersArchive,1);

clusters{n_clusters + 1} = [];%...the last one is the zero cluster...

%..filling up clusters...
for c_id = 1:n_clusters
    sub_pop_id = merged_pop(:,c_id_index) == c_id;
    sub_pop = merged_pop(sub_pop_id,:);
    sub_pop_sorted = sortrows(sub_pop,[opt.n_var + opt.n_cons + 2, opt.n_var + opt.n_cons + 1]);
    clusters{c_id} = sub_pop_sorted;
end

%...filling the cluster devoid of any leader...
sub_pop_id = merged_pop(:,c_id_index) == 0;
sub_pop = merged_pop(sub_pop_id,:);
if isempty(sub_pop) == 0
    sub_pop_sorted = sortrows(sub_pop,[opt.n_var + opt.n_cons + 2, opt.n_var + opt.n_cons + 1]);
    clusters{n_clusters + 1} = sub_pop_sorted;
end

elite_pop = zeros(size(pop));

level = 1;
n_indivs = 0;
while(1)
    for c_id = 1:(n_clusters + 1)
        if size(clusters{c_id},1) < level
            continue
        end
        n_indivs = n_indivs + 1;
        elite_pop(n_indivs,:) = clusters{c_id}(level,:);
        if n_indivs >= opt.pop_size
            break
        end
    end
    if n_indivs >= opt.pop_size
        break
    end
    level = level + 1;
end
end


function elite_pop = LeadersPreservation_naive(pop)
global opt g_vars
merged_pop = [g_vars.LeadersArchive;pop];
fit_array = merged_pop(:,opt.n_var + opt.n_cons + 1);
[~,sorted_id] = sort(fit_array);
elite_pop = merged_pop(sorted_id(1:opt.pop_size),:);
end