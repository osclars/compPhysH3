%% Task 2
hold all
fineSize = 11;
coarseSize = 21;
d = 0.2;
L= 1;
Ufine = zeros(uSize);
Ucoarse = zeros(coarseSize);
maxError = 1;
lastValue = 0;
nRuns = 0;
diPoleY = floor(uSize / 2) +1;
diPoleX1 = diPoleY + floor(d * uSize/2);
diPoleX2 = diPoleY - floor(d * uSize/2);
U(diPoleX1,diPoleY) = 1;
U(diPoleX2,diPoleY) = -1;
while maxError > 10^(-5)
          nRuns = nRuns+1;
          maxError = 0;
          for i =2:(uSize-1)
              for j = 2:(uSize-1)
                  if ~(j == diPoleY && (i == diPoleX1 || i == diPoleX2))
                      lastValue = U(i,j);
                      U(i,j) = (U(i-1,j) + U(i+1,j) + U(i,j-1) + U(i,j+1))/4;
                      lastError = abs(lastValue - U(i,j));
                      if  lastError > maxError
                          maxError = lastError; 
                      end
                  end
              end
          end
end
x = linspace(0,L,uSize);
surf(U)

hold off
