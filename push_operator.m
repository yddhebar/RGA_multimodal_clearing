%..understanding the push operator in detail..
clear all
close all
clc
eta = 1;
a = -8;
b = 10;
x_b = 0;
x = linspace(x_b - 0.1,x_b,1000);

x_mapped = a + ((x-a).*((x_b - a).^eta)).^(1/(1+eta));

plot(x,x_mapped,'--');
xlabel('x');
ylabel('x-mapped');
title('Left');
legend('eta = 1')
set(gca,'fontsize',20)

figure(3)
%..locii of a point
x_l = zeros(1,1000);
x_l(1) = a + 0.1;
for i = 2:1000
    x = x_l(i-1);
    x_l(i) = a + ((x-a).*((x_b - a).^eta)).^(1/(1+eta));
end

time = 1:1000;
semilogy(time,x_l,'*');
xlabel('time')
ylabel('x_l');
title('Locus');
legend('eta = 1')
set(gca,'fontsize',20)