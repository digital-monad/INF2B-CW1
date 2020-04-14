load "../data/dset.mat";
scatter(X(:,21),X(:,1),1,'g');
title('Graph showing correlation of Feature 21 and Feature 1');
xlabel('Feature 21');
ylabel('Feature 1');