load "../data/dset.mat";
res = 100;
epsilons = linspace(0.001,5.0,res);
lnaccs = zeros(res,1);
for i = 1:res
    lnaccs(i) = log(task1_mgc_cv(X,Y_species,1,epsilons(i),5));
end

plot(-log(epsilons),lnaccs,'r');
title("Double Log Plot of Classification Accuracy Against Epsilon");
xlabel("-ln(Epsilon)");
ylabel("ln(Classification Accuracy)");

