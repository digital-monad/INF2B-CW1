%
% Versin 0.9.1  (HS 27/03/2020)
%
function [Y] = task2_hNN_AB(X)
% Input:
%  X : N-by-D matrix of input vectors (in row-wise) (double), where D=2
% Output:
%  Y : N-by-1 vector of output (double)
    WBB = [-0.6910781222328279,0.3285779007253737,0.17913536849264527
        1.0,-0.04994357424645951,-0.17913536849264527
        0.7356832929115724,-0.18089422900442192,0.17913536849264527]'; % Weight matrix for inside B triangle
        
    WBS = [0.8847965021109446,-0.15385220407333372,-0.17913536849264527
           0.43213940858527905,0.02557924262356426,-0.17913536849264527
           -1.0,0.04994357424645951,0.17913536849264527]'; % Weight matrix for not inside small B triangle
        
    WA = -1 * [0.038150515704772674 -0.06104333355083189 0.13234412139987295
         1.0 -0.2276903206544654 -0.13234412139987295
        -0.04716752544809368 0.0995883953955948 -0.13234412139987295
        -0.5930247369060524 0.12946563165119193 0.13234412139987295]'; %Weight matrix for not A
        
    W1 = [WA WBB WBS]; % Weight matrix for layer 1
    
    W2 = [-0.5 1 1 1 1 0 0 0 0 0 0
          -2 0 0 0 0 1 1 1 0 0 0
          -0.5 0 0 0 0 0 0 0 1 1 1]';
    W2 = W2 ./ max(abs(W2));
    
    W3 = [-2 1 1 1]' ./ 2;   
    %Y = task2_hNeuron(W3,task2_hNeuron(W2,task2_hNeuron(W1,X)));
    % Same as before, loop through weights on each layer to get the values of the neurons on the next layer
    L1 = zeros(size(X,1),10);
    for w = 1:10
        L1(:,w) = task2_hNeuron(W1(:,w),X);
    end
    L2 = zeros(size(X,1),3);
    for w = 1:3
        L2(:,w) = task2_hNeuron(W2(:,w),L1);
    end
    L3 = zeros(size(X,1),1);
    for w = 1:1
        L3(:,w) = task2_hNeuron(W3(:,w),L2);
    end
    Y = L3;

end
