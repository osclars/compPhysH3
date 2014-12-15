% plot exact solution
exact = load('phi_exact_5000x5000.txt');
xExact = linspace(0, L, length(exact));
plot(xExact,exact)
grid on
set(gca,'fontsize',16);
