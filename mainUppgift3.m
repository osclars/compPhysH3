% Uppgift 3
clearvars
startSize = 11;

gamma = 1;

% remove old values from file
file = fopen('gridsizes.data','w');
fclose(file);

% ---Create source matrix---
L=1;% length of system
d=0.2; %separation of poles in x

source = zeros(startSize);
solution = zeros(startSize);
residual = zeros(startSize);

% indexes for dipole
diPoleY = floor(startSize / 2) +1;
diPoleX1 = diPoleY + floor(d * startSize/2);
diPoleX2 = diPoleY - floor(d * startSize/2);
% source values are actually 1/stepsize^2 but it will cancel
% in gaussSeidel cacluclation
source(diPoleX1,diPoleY) = 1;
source(diPoleX2,diPoleY) = -1;

% -----Solve the problem-----

%TODO where is main tol condition?
for i = 1:8
    solution = multigrid(source, solution, gamma);
    solution = interpolation(solution);
    source = interpolation(source);
end
stopSize = length(solution);
% -----Plotting-----
% plot solution
%stepsize = L/ (stopSize - 1);
%[plotX, plotY] = meshgrid(0:stepsize:L,0:stepsize:L);
%%mesh(plotX, plotY, solution)
%surf(plotX,plotY,solution,'EdgeColor','none')

figure(1)
clf
x = linspace(0,L,stopSize);
plot(x,solution(:,diPoleY))
set(gca,'fontsize',16);

% plot change in grid sizes
gridSizes = load('gridsizes.data');
figure(2)
clf
hold on
plot(gridSizes)
plot(gridSizes,'*')
set(gca,'fontsize',16);
ylabel('Grid size','fontsize',20)

% plot exact solution
figure(3)
clf
exact = load('phi_exact_5000x5000.txt');
xExact = linspace(0, L, length(exact));
plot(xExact,exact)
grid on
set(gca,'fontsize',16);
