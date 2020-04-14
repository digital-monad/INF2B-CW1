## Copyright (C) 2020 Rohan Nittur
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} computeLPP (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Rohan Nittur <s1803949@james17.inf.ed.ac.uk>
## Created: 2020-04-13

function [probs] = computeLPP (test_set, test_labels, inv_covsT, dets, M)

    probs = zeros(size(test_set,1),2); % Nx2 matrix of 'Actual' | 'Predicted' for each data point

    for i = 1:size(test_set,1)
        probs(i,1) = test_labels(i); % Fill in the actual class
        % Compute the log probabilties for all the classes - since prior uniform distribution, term ln(P(C)) can be ignored as is identical for all classes
        classProbs = -0.5 * squeeze(sum(sum(reshape((test_set(i,:)-M)',1,[],10) .* inv_covsT,2) .* reshape((test_set(i,:)-M)',[],1,10),1)) - 0.5*log(dets);
        [max_prob pred_class] = max(classProbs); % Select the most probable class
        probs(i,2) = pred_class; % Fill in the selected class
    
    end

endfunction
