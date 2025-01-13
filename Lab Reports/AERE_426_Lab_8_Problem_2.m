% AerE 426, Lab Assignment 8 - Buckling: Problem 2, Lucas Tavares

clear, clc, close all

% Problem variables
L = 28; %in
E = 10.7e3; %ksi

% Assume initial value for We
We = 3; %in

% Calculate I_stiffner
I_stiffner = (1.05 * (0.09565^3) / 12 + (1.05 * 0.09565) * (1.662 - 0.09565 / 2)^2) + (1.2 * (0.09565^3) / 12 + (1.2 * 0.09565) * (3 - 1.662 - 0.09565 / 2)^2) + (0.09565 * 3^3 / 12); %in^4

% Loop variables
error = 1;
it = 0;

while it < 4

    fprintf('\nIteration %d: \n', it+1)

    % Calculate I_skin and total I
    I_skin = (2 * We) * 0.160^3 / 12 + (2 * We) * 0.160 * 1.662^2; %in^4
    I = I_stiffner + I_skin; %in^4

    % Calculate rho
    A = (2 * We) * 0.160 + 1.05 * 0.09565 + 3 * 0.09565 + 1.2 * 0.09565; %in^2
    rho = sqrt(I / A);

    % calculate b/t and input Fcc for the skin
    b_over_t_skin = 2 * We / 0.160;
    fprintf('b/t for the skin = %.01f \n', b_over_t_skin)
    Fcc_skin = input('Please enter Fcc for the skin: ');

    % Calculate Fcc
    sum_b_t = (2 * We) * 0.160 + 1.05 * 0.09565 + 3 * 0.09565 + 1.2 * 0.09565; %in^2
    sum_b_t_Fcc = (2 * We) * 0.160 * Fcc_skin + 1.05 * 0.09565 * 42 + 3 * 0.09565 * 40 + 1.2 * 0.09565 * 38; %kip
    Fcc = sum_b_t_Fcc / sum_b_t; %ksi

    % Calculate Fcr
    Fcr = Fcc * (1 - (Fcc / (4 * pi^2 * E)) * (L / rho)^2); %ksi

    % Calculate We
    We_new = 0.85 * 0.160 * sqrt(E / Fcr); %in

    % Calculate error
    error = abs(We - We_new)/We;
    We = We_new; %in
    it = it + 1;

    % Print iteration results
    fprintf('I = %.04f in^4 \n', I)
    fprintf('Fcc = %.04f ksi \n', Fcc)
    fprintf('A = %.04f in^2 \n', A)
    fprintf('Fcr = %.04f ksi \n', Fcr)
    fprintf('Error = %.04f\n', error)
    fprintf('New We = %.04f in \n', We)

end
