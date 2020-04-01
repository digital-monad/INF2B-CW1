%
% Versin 0.9  (HS 06/03/2020)
%
function task1_3(Cov)
% Input:
%  Cov : D-by-D covariance matrix (double)
% Variales to save:
%  EVecs : D-by-D matrix of column vectors of eigen vectors (double)  
%  EVals : D-by-1 vector of eigen values (double)  
%  Cumvar : D-by-1 vector of cumulative variance (double)  
%  MinDims : 4-by-1 vector (int32)
  
  [e_vecs e_vals] = eig(Cov);
  e_vals = diag(e_vals);
  [EVals idxs] = sort(e_vals,1,'descend');
  EVecs = e_vecs(:,idxs);
  Cumvar = cumsum(EVals);
  var_ratios = Cumvar ./ Cumvar(size(Cumvar,1));
  ratio_targets = [0.7 0.8 0.9 0.95];
  [tmp idx] = max(var_ratios, [], 1)'
  MinDims = idx';
  

  save('t1_EVecs.mat', 'EVecs');
  save('t1_EVals.mat', 'EVals');
  save('t1_Cumvar.mat', 'Cumvar');
  save('t1_MinDims.mat', 'MinDims');
end
