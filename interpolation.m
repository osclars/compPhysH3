function [ finMatrix ] = interpolation( coarseMatrix )
%INTERPOLATION Multigrid method: interpolates a coarser grid to a finer one
%   coarseMatrix = the matrix you would like to interpolate

interpSize=size(coarseMatrix)*2+1; %the size of the interpolated matri
finMatrix=zeros(interpSize);
v=coarseMatrix; % shorter name for the coarser grid

%from coars to fine
for i=2:size(coarseMatrix)-1
    for j=2:size(coarseMatrix)-1
        %horizontal: stepping through the rows
        finMatrix(2*i,2*j)=v(i,j); % elements:(even,even)
        finMatrix(2*i,2*j+1) = 1/2*(v(i,j)+v(i,j+1)); % elements:(even,odd)
        %vertical: stepping through the columns
        finMatrix(2*i+1,2*j) = 1/2*(v(i,j)+v(i+1,j)); % elements:(odd,even)
        finMatrix(2*i+1,2*j+1) = 1/4*(v(i,j)+v(i+1,j)+v(i,j+1)+v(i+1,j+1)); %elements:(odd,odd)
    end
end
end

