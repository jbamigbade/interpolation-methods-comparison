function a = Coef(n, x, y)
    % Coef - Compute Newton interpolating polynomial coefficients
    % Inputs:
    %   n : degree of the polynomial
    %   x : array of x-values (1 x n+1)
    %   y : array of y-values (1 x n+1)
    % Output:
    %   a : array of coefficients (1 x n+1)
  
    % Initialize divided difference table
    dd_table = zeros(n+1, n+1);
    dd_table(:,1) = y(:);  % First column is y
  
    % Fill the divided difference table
    for j = 2:n+1
      for i = 1:n-j+2
        dd_table(i,j) = (dd_table(i+1,j-1) - dd_table(i,j-1)) / (x(i+j-1) - x(i));
      end
    end
  
    % Coefficients are the top elements of each column
    a = dd_table(1, :);
  
    % Write to output file
    filename = 'newton_coefficients.txt';
    fid = fopen(filename, 'w');
    if fid == -1
      error('Could not open file for writing.');
    endif
  
    fprintf(fid, 'Newton Interpolation Coefficients (Degree %d):\n', n);
    for i = 1:n+1
      fprintf(fid, 'a(%d) = %.10f\n', i-1, a(i));
    endfor
    fclose(fid);
  end
  