%% Task 1

tol = 10^-5;
coarseSize = 11;
fineSize = 21;
L=1;
d=0.2;
source = zeros(fineSize);
solution = zeros(fineSize);
residual = zeros(fineSize);
errorCoarse = zeros(coarseSize);
diPoleY = floor(fineSize / 2) +1;
diPoleX1 = diPoleY + floor(d * fineSize/2);
diPoleX2 = diPoleY - floor(d * fineSize/2);
source(diPoleX1,diPoleY) = 1;
source(diPoleX2,diPoleY) = -1;
% Presmooth TODO how much is a few
for i=1:3

    [solution,errorMain] = gaussSeidel(source,solution);
    
end



% Compute R
%TODO times 4?
residual = source - del2(solution);
%TODO test to calculte error on fine grid and compare with analytic
% Restrict R to coarser grid
residualCoarse = restriction(residual);

% Solve del2(E) = R
errorRes = 1;
while errorRes > tol
    %TODO source has to be coarse as well!!
    [errorCoarse, errorRes] = gaussSeidel(residualCoarse, errorCoarse);
end
% Interpolate E to fine grid
errorFine = interpolation(errorCoarse);
% Update phiApprox 
solution = solution + errorFine;
%Post smooth

for i=1:3

    [solution,errorMain] = gaussSeidel(source,solution);
    
end
