function [coarseValue] = calcCoarseValue(matrix,m,n )

transMatrix = 1/4*[1/4 1/2 1/4;1/2 1 1/2; 1/4 1/2 1/4];

coarseValue = sum(sum(transMatrix .* matrix(m-1:m+1,n-1:n+1)));
%m = floor(fineSize * (i-1) / coarseSize + (i-1)/i) + 1;




