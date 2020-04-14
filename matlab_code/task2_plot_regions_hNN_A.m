%
% Versin 0.9  (HS 06/03/2020)
%
% template script for task2_plot_regions_hNN_A.m

res = 1000;
Xvals = linspace(2.5,4,res)'; % Create X and Y coordinates
Yvals = linspace(0.5,2.5,res)';
[xs ys] = meshgrid(Xvals,Yvals);
points = [xs(:),ys(:)]; % Create a matrix of points from the coordinates
zs = reshape(task2_hNN_A(points),res,res); % Apply hNN_A function to all generated points
contourf(Xvals,Yvals,zs); % Plot all the generated results using countouf
title("Decision Regions for Polygon A");
colormap autumn;