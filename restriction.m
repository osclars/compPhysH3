function [ redMatrix ] = restriction( finMatrix )
%RESTRICTION Multigrid method: restricts a finer grid to a coarser one.
% All grid points in the coarse grid is weighted by its surounding points
% in the fin grid according to: it self 1/4, nearest neighbours 1/8, next
% nearest neighbours 1/16.
%   finerMatrix = the matrix you would like to reduce

restrictedSize = floor(size(finMatrix)/2)+1; %size of the restricted matrix
redMatrix=zeros(restrictedSize);
u=finMatrix; %shorter name for the finer grid

%from fine to coars
for i=2:restrictedSize-1
    for j=2:restrictedSize-1
        term1 = 1/4*u(2*i-1,2*j-1);
        term2 = 1/8*(u(2*i-2,2*j-1)+u(2*i-1,2*j)+u(2*i,2*j-1)+u(2*i-1,2*j-2));
        term3 = 1/16*(u(2*i-2,2*j-2)+u(2*i-2,2*j)+u(2*i,2*j)+u(2*i,2*j-2));
        redMatrix(i,j)= term1+term2+term3;
    end
end
end

