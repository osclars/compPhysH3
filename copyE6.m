%% Task 2
L=1;
d=0.2;
figure(2)
clf
hold all
grid on
uSize = [11 21 41 61 81 101 121];
cpuTime = zeros(1,length(uSize));
for n = 1:length(uSize)
      t = cputime;
      U = zeros(uSize(n));
      maxError = 1;
      lastValue = 0;
      nRuns = 0;
      diPoleY = floor(uSize(n) / 2) +1;
      diPoleX1 = diPoleY + floor(d * uSize(n)/2);
      diPoleX2 = diPoleY - floor(d * uSize(n)/2);
      U(diPoleX1,diPoleY) = 1;
      U(diPoleX2,diPoleY) = -1;
      h=L/ (uSize(n)-1);
      h=1;
      source = U/h^2;
      while maxError > 10^(-5)
          nRuns = nRuns+1;
          maxError = 0;
          for i =2:(uSize(n)-1)
              for j = 2:(uSize(n)-1)
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
    
        
      cpuTime(n)=cputime - t;
      x = linspace(0,L,uSize(n));
      plot(x,U(:,diPoleY))
      

end

  %legend('11x11', '21x21','41x41','81x81');
  hold off
  
  figure(3)
  clf
  hold all
  plot(uSize, cpuTime)
   xSize=linspace(0,uSize(end));
  
  plot(xSize,xSize.^2*cpuTime(end)/xSize(end)^2)
  plot(xSize,xSize.^4*cpuTime(end)/xSize(end)^4)
  legend('cputime', 'x^2','x^4')
  