% Uppgift 2
clearvars

clf
hold all
startSizes = [81 161 321 641 1281];
gamma = 1;
for startSize = startSizes

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
    source(diPoleX1,diPoleY) = -1;
    source(diPoleX2,diPoleY) = 1;

    % -----Solve the problem-----

    %TODO where is main tol condition?
    solution = multigrid(source, solution, gamma);
    % -----Plotting-----
    % plot solution
    %stepsize = L/ (startSize - 1);
    %[plotX, plotY] = meshgrid(0:stepsize:L,0:stepsize:L);
    %%mesh(plotX, plotY, solution)
    %surf(plotX,plotY,solution,'EdgeColor','none')

    %figure(1)
    x = linspace(0,L,startSize);
    plot(x,solution(:,diPoleY))
end
set(gca,'fontsize',20);
grid on
h_legend= legend('81', '161', '321', '641', '1281');
set(h_legend,'FontSize',16);
% plot change in grid sizes
%gridSizes = load('gridsizes.data');
%figure(2)
%clf
%hold on
%plot(gridSizes)
%plot(gridSizes,'*')
%set(gca,'fontsize',16);
%ylabel('Grid size','fontsize',20)
%
