%
% Versin 0.9  (HS 06/03/2020)
%
function task1_mgc_cv(X, Y, CovKind, epsilon, Kfolds, t)
% Input:
%  X : N-by-D matrix of feature vectors (double)
%  Y : N-by-1 label vector (int32)
%  CovKind : scalar (int32)
%  epsilon : scalar (double)
%  Kfolds  : scalar (int32)
%
% Variables to save
%  PMap   : N-by-1 vector of partition numbers (int32)
%  Ms     : C-by-D matrix of mean vectors (double)
%  Covs   : C-by-D-by-D array of covariance matrices (double)
%  CM     : C-by-C confusion matrix (double)

    train_set = X(1:4000,:); % For now, arbitrary split
    train_labels = Y(1:4000,:);
    test_set = X(t,:);
    test_labels = Y(t,:);
    Ms = zeros(10,size(X,2));

    if (CovKind == 1)
        % Full covariance matrix
        Covs = zeros(size(X,2),size(X,2),10);
        inv_covs = zeros(size(X,2),size(X,2),10);
        dets = zeros(10,1);
        for k = 1:10
            Ms(k,:) = mean(train_set(train_labels==k,:));
            Covs(:,:,k) = cov(train_set(train_labels==k,:), 1);
            Covs(:,:,k) = Covs(:,:,k) + epsilon*eye(size(Covs(:,:,k),2));
            inv_covsT(:,:,k) = inv(Covs(:,:,k))';
            dets(k,:) = det(Covs(:,:,k));
        end
        test_probs1 = -0.5 * squeeze(sum(sum(reshape((test_set-Ms)',1,[],10) .* inv_covsT,2) .* reshape((test_set-Ms)',[],1,10),1)) - 0.5*log(dets);
        %{test_probs = zeros(10,1);
        for k = 1:10
            LLPx = -0.5 * (test_set - Ms(k,:)) * inv(Covs(:,:,k)) * (test_set - Ms(k,:))' - 0.5 * log(det(Covs(:,:,k)));
            test_probs(k,:) = LLPx;
        end
        %}
        
        else
        % Shared covariance matrix
        
    end
        [max_prob pred_class] = max(test_probs1);
        printf("Predicted class: ");
        disp(pred_class);
        printf("Actual class: ");
        disp(test_labels);

    


  % save('t1_mgc_<Kfolds>cv_PMap.mat', 'PMap');
  % For each <p> and <CovKind>
  %  save('t1_mgc_<Kfolds>cv<p>_Ms.mat', 'Ms');
  %  save('t1_mgc_<Kfolds>cv<p>_ck<CovKind>_Covs.mat', 'Covs');
  %  save('t1_mgc_<Kfolds>cv<p>_ck<CovKind>_CM.mat', 'CM');
  %  save('t1_mgc_<Kfolds>cv<L>_ck<CovKind>_CM.mat', 'CM');
  % NB: replace <Kfolds>, <p>, and <CovKind> properly.

end
