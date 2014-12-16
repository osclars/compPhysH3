function [] = plotExact()
% plot exact solution
exact = load('phi_exact_5000x5000.txt');
xExact = linspace(0, 1, length(exact));
plot(xExact,exact,'r')
grid on
set(gca,'fontsize',16);
