function [solution, errorMain] = multigrid(source, solution, gamma)
% function that preform a multigrid  v- or w-cycle and returns updated solution and the
% maximum correction to value for the last run on the finest grid
% for gamma=1 V-cycle, gamma = 2 W-cycle
tol = 10^-5; % used for both main while loop and solving residual equation. 
currentSize = length(solution);
coarsestSize = 11; % when the size become this small, no more recursive step

% save current size to follow change in gridsize during simulation 
file = fopen('gridsizes.data','a');
fprintf(file,'%d\n',currentSize);
fclose(file);

% if on coarsest size, no recursive step
if currentSize == coarsestSize
    % Solve del2(E) = R
    errorRes = tol + 1;
    %solve residual equation
    while errorRes > tol
        [solution, errorRes] = gaussSeidel(source, solution);
    end

% for other sizes, solve with recursive step
else
    for i=1:3
        [solution,errorMain] = gaussSeidel(source, solution);
    end

    % Compute R
    stepsize = 1/(length(solution)-1);
    residual = source - 4*del2(solution, stepsize);

    % Restrict R to coarser grid
    residualCoarse = restriction(residual);
    coarseSize = length(residualCoarse);
    % initial guess for error 
    coarseError = zeros(coarseSize);

    % Recursive step: once for V-cycle, twice for W-cycle
    for i = 1:gamma
        coarseError  = multigrid(residualCoarse, coarseError, gamma);
    end

    % Interpolate solution to fine grid
    errorFine = interpolation(coarseError);

    % Update phiApprox 
    solution = solution + errorFine;
    %Post smooth

    for i=1:3
        [solution,errorMain] = gaussSeidel(source,solution);
    end
    % save gridsizes after recursive step as well
    file = fopen('gridsizes.data','a');
    fprintf(file,'%d\n',currentSize);
    fclose(file);
end

