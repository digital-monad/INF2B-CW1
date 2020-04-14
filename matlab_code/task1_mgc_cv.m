%
% Versin 0.9  (HS 06/03/2020)
%
function task1_mgc_cv(X, Y, CovKind, epsilon, Kfolds)
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

    numClasses = max(Y); % Get the number of classes in the datatset
    % Partition the data
    PMap = zeros(size(X,1),1);
    for class = 1:numClasses
       Nc = sum(Y == class); % Number of elements of kth class
       Mc = floor(double(Nc)/double(Kfolds)); % Number of data of class k to go in each partition
       idxs = find(Y == class); % Indices of the data of class k
       for k = 1:Kfolds-1
            PMap(idxs((k-1)*Mc + 1:k*Mc)) = k; % Assign the data to the appropriate partition
       end
       PMap(PMap == 0) = Kfolds; % Assign the remaining data to the Kth partition
       
    end
    kf = int2str(Kfolds);
    nam = strcat("t1_mgc_",kf,"cv_PMap.mat");
    save(nam, 'PMap');
    ck = int2str(CovKind);
    
    normalisedCMat = zeros(numClasses,numClasses,Kfolds); % 3D matrix to hold the confusion matrices for each fold

    for k = 1:Kfolds % Loop through each combination of train/test sets
    
      p = int2str(k);

      % Assign the test set as the current partition
      test_set = X(PMap == k,:);
      test_labels = Y(PMap == k,:);
      train_set = X(PMap != k,:);
      train_labels = Y(PMap != k,:);
      % Find the mean vectors for each class  
      Ms = zeros(numClasses,size(X,2));
      for k = 1:numClasses
          Ms(k,:) = MyMean(train_set(train_labels==k,:));
      end
      nam = strcat('t1_mgc_',kf,'cv',p,'_Ms.mat');
      save(nam, 'Ms');

      if (CovKind == 1)
          % Full covariance matrix
          Covs = zeros(size(X,2),size(X,2),numClasses);
          inv_covs = zeros(size(X,2),size(X,2),numClasses); % Convenience variable used in calculating probs
          dets = zeros(numClasses,1); % Convenience variable used in calculating probs
          for k = 1:numClasses
              Covs(:,:,k) = MyCov(train_set(train_labels==k,:));
              Covs(:,:,k) = Covs(:,:,k) + epsilon*eye(size(Covs(:,:,k),2));
              inv_covsT(:,:,k) = inv(Covs(:,:,k))';
              dets(k,:) = det(Covs(:,:,k));
          end
          
          
      elseif (CovKind == 2)
          % Diagonal covariance matrix
          Covs = zeros(size(X,2),size(X,2),numClasses);
          inv_covs = zeros(size(X,2),size(X,2),numClasses);
          dets = zeros(numClasses,1);
          for k = 1:numClasses
              Covs(:,:,k) = diag(diag(MyCov(train_set(train_labels==k,:))));
              Covs(:,:,k) = Covs(:,:,k) + epsilon*eye(size(Covs(:,:,k),2));
              inv_covsT(:,:,k) = inv(Covs(:,:,k))';
              dets(k,:) = det(Covs(:,:,k));
          end
          
          
      else
          % Shared covariance matrix
          Covs = repmat(MyCov(train_set) + epsilon*eye(24,24),1,1,numClasses);
          inv_covsT = repmat(inv(MyCov(train_set))',1,1,numClasses);
          dets = repmat(det(MyCov(train_set)),numClasses,1);
      end
      
      Covs = permute(Covs,[3,2,1]);
      nam = strcat('t1_mgc_',kf,'cv',p,'_ck',ck,'_Covs.mat');
      save(nam, 'Covs');
      
      
      LPP = computeLPP(test_set,test_labels,inv_covsT,dets,Ms); % Compute log post probs and select the most likely class
      CM = myConMat(LPP,numClasses);
      nam = strcat('t1_mgc_',kf,'cv',p,'_ck',ck,'_CM.mat');
      save(nam, 'CM');
      confus = CM./  size(test_set,1); % Create and normalise the confusion matrix
      normalisedCMat(:,:,k) = confus;
    
   end
   
   CM = sum(normalisedCMat,3) ./ Kfolds; % Create the final confusion matrix
   L = int2str(Kfolds+1);
   nam = strcat('t1_mgc_',kf,'cv',L,'_ck',ck,'_CM.mat');
   save(nam, 'CM');
   acc = sum(diag(CM))/ sum(sum(CM));
   %disp(acc);
        

    


  % save('t1_mgc_<Kfolds>cv_PMap.mat', 'PMap');
  % For each <p> and <CovKind>
  %  save('t1_mgc_<Kfolds>cv<p>_Ms.mat', 'Ms');
  %  save('t1_mgc_<Kfolds>cv<p>_ck<CovKind>_Covs.mat', 'Covs');
  %  save('t1_mgc_<Kfolds>cv<p>_ck<CovKind>_CM.mat', 'CM');
  %  save('t1_mgc_<Kfolds>cv<L>_ck<CovKind>_CM.mat', 'CM');
  % NB: replace <Kfolds>, <p>, and <CovKind> properly.

end
