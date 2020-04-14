%
% Versin 0.9  (HS 06/03/2020)
%
% template script for task2_plot_regions_sNN_AB
res = 100;
Xvals = linspace(-2,8,res)'; % Create X and Y coordinates
Yvals = linspace(-2,8,res)';
[xs ys] = meshgrid(Xvals,Yvals);
points = [xs(:),ys(:)]; % Create the set of points
zs = reshape(task2_sNN_AB(points),res,res); % Run hNN_AB on all points
contourf(Xvals,Yvals,zs); % Plot the results of the function on all the points
title("Decision Regions for Task 2 (S-Neurons)");
colormap autumn;



