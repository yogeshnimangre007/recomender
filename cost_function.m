function [J, grad] = cofiCostFunc(params, Y, R, num_users, num_movies, ...
                                  num_features, lambda)

% Unfold the U and W matrices from params
X = reshape(params(1:num_symtom*num_remidies), num_symtom, num_remidies);
Theta = reshape(params(num_symtom*num_remidies+1:end), ...
                num_patient, num_remidies);

            


J = (1/2).*sum(sum(((X*Theta').*R-Y.*R).^2))+(lambda./2.*sum(sum(Theta.^2)))+(lambda./2.*sum(sum(X.^2)));	

X_grad = (((X*Theta').*R*Theta-Y.*R*Theta)+lambda.*X);
Theta_grad = ((X'*((X*Theta').*R)-X'*(Y.*R)))'+lambda.*Theta;


grad = [X_grad(:); Theta_grad(:)];

end