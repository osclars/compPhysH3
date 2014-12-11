function [ redMatrix ] = restriction( finMatrix )
%RESTRICTION Multigrid method: restricts a finer grid to a coarser one
%   finerMatrix = the matrix you would like to reduce

restrictedSize = floor((size(finMatrix)-1)/2); %size of the restricted matrix
redMatrix=zeros(restrictedSize);
u=finMatrix; %shorter name for the finer grid

%from fine to coars
for i=2:restrictedSize-1
    for j=2:restrictedSize-1
        % for all elements on the diagonal
        if i==j
            term1 = 1/4*u(2*i,2*j);
            term2 = 1/8*(u(2*i-1,2*j)+u(2*i+1,2*j)+u(2*i,2*j-1)+u(2*i,2*j+1));
            term3 = 1/16*(u(2*i-1,2*j-1)+u(2*i-1,2*j+1)+u(2*i+1,2*j-1)+u(2*i+1,2*j-1));
            redMatrix(i,j)= term1+term2+term3;
        end
        %for all off-diagonal elements
        term1 = 1/4*u(2*i,2*j);
        term2 = 1/8*(u(2*i-1,2*j)+u(2*i+1,2*j)+u(2*i,2*j-1)+u(2*i,2*j+1));
        term3 = 1/16*(u(2*i-1,2*j-1)+u(2*i-1,2*j+1)+u(2*i+1,2*j-1)+u(2*i+1,2*j+1));
        redMatrix(i,j)= term1+term2+term3;
        
    end
end

end

