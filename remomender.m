%% ============== Entering ratings for a new pateint ===============
%  Before we will train the collaborative filtering model, we will first
%  add ratings that correspond to a new patient that we just observed. 

symtom_list = load_symtom_list();

%  Initialize my ratings
my_treatment = zeros(1682, 1);

my_treatment(1) = 4;


my_treatment(98) = 2;

my_treatment(7) = 3;
my_treatment(12)= 5;
my_treatment(54) = 4;
my_treatment(64)= 5;
my_treatment(66)= 3;
my_treatment(69) = 5;
my_treatment(183) = 4;
my_treatment(226) = 5;
my_treatment(355)= 5;

fprintf('\n\nNew patient treatment:\n');
for i = 1:length(my_treatment)
    if my_treatment(i) > 0 
        fprintf('treatment %d for %s\n', my_treatment(i), ...
                 symtom_list{i});
    end
end

load('data.mat');

Y = [my_ratings Y];
R = [(my_ratings ~= 0) R];

%  Normalize treatment

[Ynorm, Ymean] = normalizeRatings(Y, R);

%  Useful Values
num_patient = size(Y, 2);
num_symtom = size(Y, 1);
num_cures = 10;

% Set Initial Parameters (Theta, X)
X = randn(num_symtom, num_cures);
Theta = randn(num_patient, num_cures);

initial_parameters = [X(:); Theta(:)];

% Set options for fmincg
options = optimset('GradObj', 'on', 'MaxIter', 100);

% Set Regularization
lambda = 10;
theta = fmincg (@(t)(cofiCostFunc(t, Ynorm, R, num_patient, num_symtom, ...
                                num_cures, lambda)), ...
                initial_parameters, options);

% Unfold the returned theta back into U and W
X = reshape(theta(1:num_symtom*num_cures), num_symtom, num_cures);
Theta = reshape(theta(num_symtom*num_cures+1:end), ...
                num_patient, num_cures);




p = X * Theta';
my_predictions = p(:,1) + Ymean;

symtom_list = load_symtom_list();

[r, ix] = sort(my_predictions, 'descend');

for i=1:10
    j = ix(i);
    fprintf('Predicting symtom rate %.1f for symtom %s\n', my_predictions(j), ...
            symtom_list{j});
end


for i = 1:length(my_ratings)
    if my_ratings(i) > 0 
        fprintf('checked %d for %s\n', my_treatment(i), ...
                 symtom_List{i});
    end
end