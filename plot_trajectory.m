figure;

plot(out.xout.Data,out.yout.Data);
axis equal;
grid on;
xlabel('x'); ylabel('y');

figure;

r = Re;                 
cx = 0; cy = 0; 

theta = linspace(0, 2*pi, 200);   % angle values
x = cx + r*cos(theta);
y = cy + r*sin(theta);

plot(x, y, 'LineWidth', 2)
axis equal;
grid on;

hold on;
plot(out.xout1.Data,out.yout1.Data);

xlabel('x'); ylabel('y');
hold off;
