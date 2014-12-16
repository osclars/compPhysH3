%% Task 1
clearvars
tol = 10^-5; % used for both main while loop and solving residual equation. 
fineSize = 21;
L=1;% length of system
d=0.2; %separation of poles in x

source = zeros(fineSize);
solution = zeros(fineSize);
residual = zeros(fineSize);

% indexes for dipole in fine grid
diPoleY = floor(fineSize / 2) +1;
diPoleX1 = diPoleY + floor(d * fineSize/2);
diPoleX2 = diPoleY - floor(d * fineSize/2);

% assign values to source
stepsize = L/ (fineSize - 1);
source(diPoleX1,diPoleY) = -1/ stepsize^2;
source(diPoleX2,diPoleY) = 1/ stepsize^2;

% to always start while first time
errorMain = tol +1;
% count how many times gaussSeidel is called on fine grid
nGS = 0;
% check condition on fine grid
while errorMain > tol
    %----- Presmooth----
    for i=1:3
        nGS = nGS +1;
        [solution,errorMain] = gaussSeidel(source,solution);
    end

    % -----Compute Residual-----

    residual = source -4* del2(solution, stepsize);

    % Restrict Residual to coarser grid
    residualCoarse = restriction(residual);

    % -----Solve del2(E) = R-----
    coarseSize = length(residualCoarse);
    % initial guess for error is zero
    errorCoarse = zeros(coarseSize);

    % to always start while first time
    errorRes = tol + 1;
    % check condition on coarse grid
    while errorRes > tol
        [errorCoarse, errorRes] = gaussSeidel(residualCoarse, errorCoarse);
    end
    % -----Interpolate E to fine grid-----
    errorFine = interpolation(errorCoarse);
    % -----Update phiApprox -----
    solution = solution + errorFine;

    %-----Post smooth-----
    for i=1:3
        nGS = nGS +1;
        [solution,errorMain] = gaussSeidel(source,solution);
    end
end
xPlot = linspace(0,L,fineSize);
plot(xPlot,solution(:,diPoleY))
grid on
set(gca,'fontsize',16);
