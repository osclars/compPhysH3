% Uppgift 3
% First thing in main for loop is interpolation,
% so start on a size smaller than you actually want
startSize = 6;
currentSize = startSize;

% use v-cycle multigrid
gamma = 1;

tol = 10^-5;

% remove old values from file that saves gridsizes
file = fopen('gridsizes.data','w');
fclose(file);

L=1;% length of system
d=0.2; %separation of poles in x

solution = zeros(startSize);
residual = interpolation(zeros(startSize));


% -----Solve the problem-----
% when i goes to 8 the final size will be 1281
for i = 1:8
    % ---Create source matrix of correct size---
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

    %solve problem whith a v-cycle multigrid with currentSize
    maxCorrection = tol +1;
    while maxCorrection > tol
        [solution, maxCorrection] = multigrid(source, solution, gamma);
    end
end
% for plotting x-vectors 
stopSize = length(solution);
% -----Plotting-----

figure(2)
clf
hold all
x = linspace(0,L,stopSize);
plotExact
plot(x,solution(:,diPoleY),'--b')
[maxValue,maxIndex] = max(solution(:,diPoleY));
[minValue,minIndex] = min(solution(:,diPoleY));
% plot max and min value for solution
plot(x(minIndex), minValue, 'ob', 'MarkerSize', 10)
plot(x(maxIndex), maxValue, 'ob', 'MarkerSize', 10)
set(gca,'fontsize',16);
grid on
legend('Analytical solution', 'Full Multigrid-method', 'location', 'best');

% plot change in grid sizes
gridSizes = load('gridsizes.data');
figure(3)
clf
hold on
plot(gridSizes)
plot(gridSizes,'*')
set(gca,'fontsize',16);
ylabel('Grid size','fontsize',20)

