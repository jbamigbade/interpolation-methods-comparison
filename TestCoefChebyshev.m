% TestCoefChebyshev.m
% Interpolation of atan(x) using Newton's method with Chebyshev nodes

graphics_toolkit('gnuplot');  % Force gnuplot to avoid OpenGL errors

% Step 1: Define Chebyshev nodes on [-5, 5]
n = 20;
x_cheb = zeros(1, n+1);
for i = 0:n
    x_cheb(i+1) = 5 * cos((2*i + 1) * pi / (2*(n + 1)));  % Chebyshev formula
endfor
y_cheb = atan(x_cheb);  % Function values at Chebyshev nodes

% Step 2: Compute Newton interpolation coefficients
a = Coef(n, x_cheb, y_cheb);

% Step 3: Define test evaluation points
t_values = linspace(-5, 5, 200);
true_values = atan(t_values);
interp_values = zeros(size(t_values));

% Step 4: Evaluate Newton polynomial at test points
for i = 1:length(t_values)
    interp_values(i) = Eval(n, x_cheb, a, t_values(i));
endfor

% Step 5: Compute and display error
errors = abs(true_values - interp_values);
max_error = max(errors);
fprintf('Max error using Chebyshev nodes (n = 20): %.10f\n', max_error);

% Step 6: Plot function vs interpolation
figure;
plot(t_values, true_values, 'b-', 'LineWidth', 2); hold on;
plot(t_values, interp_values, 'r--', 'LineWidth', 2);
legend('atan(x)', 'Interpolated P(x)', 'Location', 'northwest');
title('atan(x) vs Newton Interpolation with Chebyshev Nodes (n = 20)');
xlabel('x'); ylabel('y');
grid on;
print('chebyshev_vs_atan.png', '-dpng');
pause;  % Optional delay for visual inspection

% Step 7: Plot absolute error
figure;
plot(t_values, errors, 'k-', 'LineWidth', 1.5);
title('Absolute Error |atan(x) - P(x)| using Chebyshev Nodes');
xlabel('x'); ylabel('|Error|');
grid on;
print('chebyshev_error.png', '-dpng');
pause;

% Step 8: Save error data to text file
fid = fopen('chebyshev_interpolation_errors.txt', 'w');
fprintf(fid, 't\tatan(t)\t\tP(t)\t\t|Error|\n');
for i = 1:length(t_values)
    fprintf(fid, '%.4f\t%.10f\t%.10f\t%.10f\n', ...
        t_values(i), true_values(i), interp_values(i), errors(i));
endfor
fclose(fid);
fprintf('Saved results to chebyshev_interpolation_errors.txt\n');
