function [solution] = multigrid(source, solution, gamma)
% for gamma=1 V-cycle, gamma = 2 W-cycle
tol = 10^-5; % used for both main while loop and solving residual equation. 
currentSize = length(solution);
coarsestSize = 11;
file = fopen('gridsizes.data','a');
%fwrite(file,currentSize);
fprintf(file,'%d\n',currentSize);
fclose(file);

% if on coarsest size, no recursive step
if currentSize == coarsestSize
    % Solve del2(E) = R
    errorRes = tol + 1;
    while errorRes > tol
        [solution, errorRes] = gaussSeidel(source, solution);
    end

% for other sizes, solve with recursive step
else
    for i=1:3
        [solution,errorMain] = gaussSeidel(source, solution);
    end

    % Compute R
    % TODO how does this relate to in parameter with same name?
    residual = source + del2(solution);

    % Restrict R to coarser grid
    residualCoarse = restriction(residual);
    coarseSize = length(residualCoarse);
    coarseError = zeros(coarseSize);

    % Recursive step ones for V-cycle
    for i = 1:gamma
        coarseError = multigrid(residualCoarse, coarseError, gamma);
    end

    file = fopen('gridsizes.data','a');
    %TODO is it good to print in else?
    %fwrite(file,currentSize);
    fprintf(file,'%d\n',currentSize);
    fclose(file);
    % Interpolate solution to fine grid
    errorFine = interpolation(coarseError);

    % Update phiApprox 
    solution = solution + errorFine;
    %Post smooth

    for i=1:3
        [solution,errorMain] = gaussSeidel(source,solution);
    end
end

