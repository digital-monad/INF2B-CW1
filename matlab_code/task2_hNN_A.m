%
% Versin 0.9.1  (HS 06/03/2020)
%
function [Y] = task2_hNN_A(X)
% Input:
%  X : N-by-D matrix of input vectors (in row-wise) (double), where D=2
% Output:
%  Y : N-by-1 vector of output (double)

    W1 = [0.038150515704772674 -0.06104333355083189 0.13234412139987295
         1.0 -0.2276903206544654 -0.13234412139987295
        -0.04716752544809368 0.0995883953955948 -0.13234412139987295
        -0.5930247369060524 0.12946563165119193 0.13234412139987295]'; % Weight matrix for layer 1
        
    W2 = [-1.0 0.3333333333333333 0.3333333333333333 0.3333333333333333 0.3333333333333333]'; %Weight matrix for layer 2
    
    %Y = task2_hNeuron(W2,task2_hNeuron(W1,X));
    L1 = zeros(size(X,1),4); % Matrix representing the values of neurons in layer 1
    for w = 1:4
        L1(:,w) = task2_hNeuron(W1(:,w),X); %Loops through the weight vectors and finds the values of the neurons on the next layer
    end
    L2 = zeros(size(X,1),1);
    for w = 1:1
        L2(:,w) = task2_hNeuron(W2(:,w),L1);
    end
    Y = L2; % Assign the output to be the value of the single neuron on the last layer
end
