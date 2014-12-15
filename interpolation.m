function [ finMatrix ] = interpolation( coarseMatrix )
%INTERPOLATION Multigrid method: interpolates a coarser grid to a finer
%one.
% FOr each point in the coarse grid the nearest neighbours are given 1/2 of 
% its value, the next nearest neighbours are given 1/4.
%   coarseMatrix = the matrix you would like to interpolate

interpSize=size(coarseMatrix)*2-1; %the size of the interpolated matri
finMatrix=zeros(interpSize);
v=coarseMatrix; % shorter name for the coarser grid

%from coars to fine
for i=1:size(coarseMatrix)-1
    for j=1:size(coarseMatrix)-1
        finMatrix(2*i-1,2*j-1)  = v(i,j); % indices (odd, odd) in finMatrix
        finMatrix(2*i-1,2*j)    = 1/2*(v(i,j)+v(i,j+1)); %% indices (odd, even) in finMatrix 
        finMatrix(2*i,2*j-1)    = 1/2*(v(i,j)+v(i+1,j)); % indices (even, odd) in finMatrix
        finMatrix(2*i,2*j)      = 1/4*(v(i,j)+v(i+1,j)+v(i,j+1)+v(i+1,j+1)); % indices (even, even) in finMatrix
    end
end
end

