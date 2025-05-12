% TestCoefEval2.m
% Interpolation of atan(x) using Newton's divided difference method
% Uses Coef.m and Eval.m

% Force Octave to use gnuplot to avoid OpenGL rendering issues
graphics_toolkit('gnuplot');

% Step 1: Define interpolation data (11 points on [1,6])
x_data = linspace(1, 6, 11);
y_data = atan(x_data);
n = length(x_data) - 1;

% Step 2: Compute Newton coefficients using divided differences
a = Coef(n, x_data, y_data);

% Step 3: Display the coefficients
disp('Newton interpolation coefficients:');
disp(a');

% Step 4: Define evaluation points on [0,8]
t_values = linspace(0, 8, 33);
true_values = atan(t_values);
interp_values = zeros(size(t_values));

% Step 5: Evaluate the Newton polynomial at all t values
for i = 1:length(t_values)
  interp_values(i) = Eval(n, x_data, a, t_values(i));
endfor

% Step 6: Calculate errors
errors = abs(true_values - interp_values);
max_error = max(errors);
fprintf('Maximum absolute discrepancy: %.10f\n', max_error);

% Step 7: Plot function vs interpolation
figure;
plot(t_values, true_values, 'b-', 'LineWidth', 2); hold on;
plot(t_values, interp_values, 'r--', 'LineWidth', 2);
legend('atan(x)', 'Newton Interpolation', 'Location', 'northwest');
title('atan(x) vs Newton Interpolating Polynomial (Degree 10)');
xlabel('x'); ylabel('y');
grid on;
print('atan_vs_interpolation.png', '-dpng');
pause;  % Optional: keep window open before next plot

% Step 8: Plot absolute error
figure;
plot(t_values, errors, 'k-o');
title('Absolute Error |atan(x) - P(x)|');
xlabel('x'); ylabel('|Error|');
grid on;
print('interpolation_error.png', '-dpng');
pause;  % Optional: keep window open before closing

% Step 9: Save evaluation and error table to text file
fid = fopen('interpolation_errors.txt', 'w');
fprintf(fid, 't\tatan(t)\t\tP(t)\t\t|Error|\n');
for i = 1:length(t_values)
  fprintf(fid, '%.4f\t%.10f\t%.10f\t%.10f\n', ...
    t_values(i), true_values(i), interp_values(i), errors(i));
endfor
fclose(fid);
fprintf('Saved results to interpolation_errors.txt\n');
