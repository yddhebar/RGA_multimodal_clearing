%..report...
function [] = report(pop)
global opt
X = pop(:,1:opt.n_var);
fitness_id = opt.n_var + opt.n_cons + 1;
F = pop(:,fitness_id);% + max(pop(:,fitness_id))*pop(:,fitness_id + 1);
optima_pts = [F,X];
save('optima.txt','optima_pts','-ascii');
end