%% V-cycle 
clearvars
tol = 10^-5; % used for both main while loop and solving residual equation. 
coarseSize = 11;
fineSize = 21;
L=1;% length of system
d=0.2; %separation of poles in x

source = zeros(fineSize);
solution = zeros(fineSize);
residual = zeros(fineSize);
errorCoarse = zeros(coarseSize);

% indexes for dipole
diPoleY = floor(fineSize / 2) +1;
diPoleX1 = diPoleY + floor(d * fineSize/2);
diPoleX2 = diPoleY - floor(d * fineSize/2);
% source values are actually 1/stepsize^2 but it will cancel
% in gaussSeidel cacluclation
source(diPoleX1,diPoleY) = -1;
source(diPoleX2,diPoleY) = 1;
% For plotting
stepsize = L/ (fineSize - 1);
[plotX, plotY] = meshgrid(0:stepsize:L,0:stepsize:L);
errorMain = tol +1;
nGS = 0;
while errorMain > tol
    % Presmooth TODO how much is a few
    for i=1:3
        nGS = nGS +1;
        [solution,errorMain] = gaussSeidel(source,solution);

    end

    % Compute R
    %times 4, probably not?
    residual = source + del2(solution);

    % Restrict R to coarser grid
    residualCoarse = restriction(residual);

    % Solve del2(E) = R
    errorRes = 1;
    while errorRes > tol
        [errorCoarse, errorRes] = gaussSeidel(residualCoarse, errorCoarse);
    end
    % Interpolate E to fine grid
    errorFine = interpolation(errorCoarse);
    % Update phiApprox 
    solution = solution + errorFine;
    %Post smooth

    for i=1:3

        nGS = nGS +1;
        [solution,errorMain] = gaussSeidel(source,solution);

    end
end

surf(plotX, plotY, solution)
set(gca,'fontsize',16);
