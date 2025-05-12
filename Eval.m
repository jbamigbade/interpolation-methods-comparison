function v = Eval(n, x, a, t)
    % Eval - Evaluate the Newton interpolating polynomial at point t
    % Inputs:
    %   n : degree of the polynomial
    %   x : array of x-values (1 x n+1)
    %   a : array of coefficients from Coef (1 x n+1)
    %   t : the point at which to evaluate the polynomial
    % Output:
    %   v : value of the polynomial at t
  
    % Initialize result with the last coefficient
    v = a(n+1);
  
    % Perform nested multiplication (Horner’s method for Newton form)
    for i = n:-1:1
      v = a(i) + (t - x(i)) * v;
    endfor
  end
  