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
## @deftypefn {Function File} {@var{retval} =} myConMat (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Rohan Nittur <s1803949@james17.inf.ed.ac.uk>
## Created: 2020-04-13

function [C] = myConMat (O,numC)

    C = zeros(numC,numC);
    for i = 1:size(O,1)
        actual = O(i,1); pred = O(i,2);
        C(actual,pred) = C(actual,pred) + 1;
    end

endfunction
