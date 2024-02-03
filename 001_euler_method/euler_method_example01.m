clc; clear; close all;

t0        = 1.0;           %   t starting value
t_final   = 6.0;           %   t final value
y0        = 3.0;           %   initial condition for y

% Step sizes
h1 = 1;
h2 = h1 / 2.0;
h3 = h2 / 2.0;

t1 = t0 : h1 : t_final;
t2 = t0 : h2 : t_final;
t3 = t0 : h3 : t_final;

% dy/dt
dy = @(t) -5*t;

ode_solution = @(t) -2.5 * t .^ 2 + 5.5;

y1 = [y0];
y2 = [y0];
y3 = [y0];

for t = t1
    y1 = [y1, y1(end) + h1 * dy(t)];
end

for t = t2
    y2 = [y2, y2(end) + h2 * dy(t)];
end

for t = t3
    y3 = [y3, y3(end) + h3 * dy(t)];
end

y1 = y1(1 : end - 1);
y2 = y2(1 : end - 1);
y3 = y3(1 : end - 1);

error_1 = (ode_solution(t1) - y1);
error_2 = (ode_solution(t2) - y2);
error_3 = (ode_solution(t3) - y3);

linewidth = 1.1;
figure; grid on; hold on;
title("ODE solution and approximations with different step sizes")
plot(t3, ode_solution(t3), 'b', "LineWidth", linewidth)
plot(t1,               y1, 'r', "LineWidth", linewidth)
plot(t2,               y2, 'k', "LineWidth", linewidth)
plot(t3,               y3, 'm', "LineWidth", linewidth)
legend("y = -2.5t^2 + 5.5", ...
       "h = " + num2str(h1), ...
       "h = " + num2str(h2), ...
       "h = " + num2str(h3))
ylabel("y")
xlabel("t")
xlim([t0,t_final])

figure; grid on; hold on;
title("ODE approximation errors with different step sizes")
plot(t1, error_1, 'r', "LineWidth", linewidth)
plot(t2, error_2, 'k', "LineWidth", linewidth)
plot(t3, error_3, 'm', "LineWidth", linewidth)
legend("h = " + num2str(h1), "h = " + num2str(h2), "h = " + num2str(h3))
ylabel("Error")
xlabel("t")
xlim([t0,t_final])

printOutMarkdown = true;

if printOutMarkdown
    for i = 2 : length(t1)
        fprintf("$y(%.2f) = y(%.2f) + h \\cdot y'(%.2f) = " + ...
               "%.2f + %.2f \\cdot (-5.0) \\cdot %.2f = %.2f$\n\n", ...
               t1(i), t1(i-1), t1(i-1), y1(i-1), h1, t1(i-1), y1(i));
    end
end


