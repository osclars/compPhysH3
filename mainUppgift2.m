% Uppgift 2
tol = 10^-5;
hold all
startSizes = [81 161 321 641 1281];
cpuTime = zeros(1, length(startSizes));
plotColor = [ 'r' 'g' 'b' 'k' 'r'];
lineType = '';
counter = 0;
gamma = 2;
for startSize = startSizes
    counter = counter +1;

    % remove old values from file
    file = fopen('gridsizes.data','w');
    fclose(file);

    tmpTime = cputime; % start timing
    % ---Create source matrix---
    L=1;% length of system
    d=0.2; %separation of poles in x

    source = zeros(startSize);
    solution = zeros(startSize);
    residual = zeros(startSize);
    stepsize = 1/ (startSize - 1);
    % indexes for dipole
    diPoleY = floor(startSize / 2) +1;
    diPoleX1 = diPoleY + floor(d * startSize/2);
    diPoleX2 = diPoleY - floor(d * startSize/2);
    source(diPoleX1,diPoleY) = -1/ stepsize^2;
    source(diPoleX2,diPoleY) = 1/ stepsize^2;

    % -----Solve the problem-----

    nMultigrids =0;    % counter for while-loop
    maxCorrection = tol +1;
    while maxCorrection  > tol
        nMultigrids = nMultigrids +1;
        [solution, maxCorrection]  = multigrid(source, solution, gamma);
    end
    cpuTime(counter) = cputime- tmpTime ;% save cpu time

    % -----Plotting-----

    figure(1)
    x = linspace(0,L,startSize);
    plot(x,solution(:,diPoleY),strcat(plotColor(counter),lineType),'MarkerSize',1)
end
% make pretty figure
set(gca,'fontsize',20);
grid on
h_legend= legend('81', '161', '321', '641', '1281');
set(h_legend,'FontSize',18);
hold off
% plot change in grid sizes
gridSizes = load('gridsizes.data');
figure(2)
clf
hold on
plot(gridSizes)
plot(gridSizes,'*')
set(gca,'fontsize',18);
ylabel('Grid size','fontsize',20)
