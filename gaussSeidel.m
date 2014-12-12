function [solution,maxError] = gaussSeidel(source, solution)
% Function that runs one Gauss-Seidel cycle and returns the
% updated solution and the largest correction to a value
L=1;
d=0.2;
gridSize  = length(source);

%TODO step size in here or outside?
% difference for error and poisson
lastValue = 0;
maxError = 0; 
for i =2:(gridSize-1)
     for j = 2:(gridSize-1)
          lastValue = solution(i,j);
          solution(i,j) = (solution(i-1,j) + solution(i+1,j) + solution(i,j-1) + solution(i,j+1))/4 + source(i,j);
          lastError = abs(lastValue - solution(i,j));
          if  lastError > maxError
              maxError = lastError; 
          end
     end
end

