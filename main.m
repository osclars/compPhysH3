%% Task 1

tol = 10^-5;
%coarseSize = 11;
fineSize = 21;
L=1;
d=0.2;
source = zeros(fineSize);
solution = zeros(fineSize);
residual = zeros(fineSize);
errorCourse = zeros(fineSize);
diPoleY = floor(fineSize / 2) +1;
diPoleX1 = diPoleY + floor(d * fineSize/2);
diPoleX2 = diPoleY - floor(d * fineSize/2);
source(diPoleX1,diPoleY) = 1;
source(diPoleX2,diPoleY) = -1;
% Presmooth
for i=1:3

    [solution,errorMain] = gaussSeidel(source,solution);
    
end



% Compute R

residual = source - 4*del2(solution);

% Restrict R to coarser grid
residualCoarse = restriction(residual);

% Solve del2(E) = R
errorRes = 1;
while errorRes > tol
    [errorCourse, errorRes] = gaussSeidel(residualCoarse, errorCourse);
end
% Interpolate E to fine grid
errorFine = interpolation(errorCourse);
% Update phiApprox 
solution = solution + errorFine;
%Post smooth

for i=1:3

    [solution,errorMain] = gaussSeidel(source,solution);
    
end
