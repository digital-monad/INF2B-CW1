%
% Versin 0.9  (HS 06/03/2020)
%
% template script for task2_plot_regions_sNN_AB
res = 1000;
Xvals = linspace(-2,8,res)';
Yvals = linspace(-2,8,res)';
%Yvals = linspace(1.0,2.2,5)';
[xs ys] = meshgrid(Xvals,Yvals);
points = [xs(:),ys(:)];
zs = reshape(task2_sNN_AB(points),res,res);
contourf(Xvals,Yvals,zs);
title("Decision Regions for Task 2 (S-Neurons)");
colormap autumn;



