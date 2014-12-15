function [solution,maxCorrection] = gaussSeidel(source, solution)
% Function that runs one Gauss-Seidel cycle and returns the
% updated solution and the largest correction to a value
gridSize  = length(source);

lastValue = 0;
maxCorrection = 0; 
% don't go to edges due to boundery conditions
for i =2:(gridSize-1)
     for j = 2:(gridSize-1)
         %save last value to compare
          lastValue = solution(i,j);
          % caclulate new value
          solution(i,j) = (solution(i-1,j) + solution(i+1,j) + solution(i,j-1) + solution(i,j+1) - source(i,j))/4;
          lastCorrection = abs(lastValue - solution(i,j));
          if  lastCorrection > maxCorrection
              maxCorrection = lastCorrection; 
          end
     end
end

