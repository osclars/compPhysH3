% Uppgift 3
clearvars
startSize = 6;
currentSize = startSize;

gamma = 1;

% remove old values from file
file = fopen('gridsizes.data','w');
fclose(file);

% ---Create source matrix---
L=1;% length of system
d=0.2; %separation of poles in x

solution = zeros(startSize);
residual = interpolation(zeros(startSize));


% -----Solve the problem-----

%TODO where is main tol condition?
for i = 1:8
    solution = interpolation(solution);
    currentSize = length(solution);
    source = zeros(currentSize);
    % indexes for dipole
    diPoleY = floor(currentSize / 2) +1;
    diPoleX1 = diPoleY + floor(d * currentSize/2);
    diPoleX2 = diPoleY - floor(d * currentSize/2);
    stepsize = 1/ (currentSize - 1);
    source(diPoleX1,diPoleY) = -1/ stepsize^2;
    source(diPoleX2,diPoleY) = 1/ stepsize^2;

    solution = multigrid(source, solution, gamma);
end
stopSize = length(solution);
% -----Plotting-----

figure(1)
clf
hold all
x = linspace(0,L,stopSize);
plotExact
plot(x,solution(:,diPoleY),'--b')
[maxValue,maxIndex] = max(solution(:,diPoleY));
[minValue,minIndex] = min(solution(:,diPoleY));
plot(x(minIndex), minValue, 'ob', 'MarkerSize', 10)
plot(x(maxIndex), maxValue, 'ob', 'MarkerSize', 10)
set(gca,'fontsize',16);
grid on
legend('Analytical solution', 'Full Multigrid-method', 'location', 'best');
% plot change in grid sizes
gridSizes = load('gridsizes.data');
figure(2)
clf
hold on
plot(gridSizes)
plot(gridSizes,'*')
set(gca,'fontsize',16);
ylabel('Grid size','fontsize',20)

