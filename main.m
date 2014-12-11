%% Task 1

tol = 10^-5;
coarseSize = 11;
fineSize = 21;

% create source (only copied, fix before use TODO)
diPoleY = floor(uSize / 2) +1;
diPoleX1 = diPoleY + floor(d * uSize/2);
diPoleX2 = diPoleY - floor(d * uSize/2);
U(diPoleX1,diPoleY) = 1;
U(diPoleX2,diPoleY) = -1;
h=L/ (uSize-1);
source = U/h^2;
%if ~(j == diPoleY && (i == diPoleX1 || i == diPoleX2))


% Presmooth

% Compute R

% Restrict R to coarser grid

% Solve del2(E) = R

% Interpolate E to fine grid

% Update phiApprox 

%Post smooth
