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
## @deftypefn {Function File} {@var{retval} =} temp (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Rohan Nittur <s1803949@james17.inf.ed.ac.uk>
## Created: 2020-04-14

function temp (X,Y,PC)

    %scatter(1:24,cv,'r');
    %title("Plot of Cumulative Variance Against Number of Prinical Components");
    %xlabel("Number of Components");
    %ylabel("Cumulative Variance");
    
    PC_X = X * PC;
    gscatter(PC_X(:,1), PC_X(:,2), Y);
    title("Data Projected Onto 2D PCA Plane Coloured By Class");
    xlabel("First Principal Component");
    ylabel("Second Principal Component");

endfunction
