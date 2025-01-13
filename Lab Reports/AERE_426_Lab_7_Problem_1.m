% AerE 426, Lab Assignment 7 - Adhesive Joint: Problem 1, Lucas Tavares

clear, clc, close all

% Adhesive thicknesses
ta = [2.5e-3, 5.5e-3, 7.5e-3, 9.5e-3]; %in

% Strips thicknesses
t1 = 0.25; %in
t2 = 0.25; %in

% Strips Young's modulus and Poisson's ratio
E0 = 10e6; %psi
nu = 0.33;

% Strips width
w = 1; %in

% Adhesive properties at 75 F
G = 63685; %psi
tau_p = 5255; %psi
delta_u = 0.0052; %in
delta_e = 0.00074; %in
tau_u = 6950; %psi
Ec = 1.6e5; %psi

%Strain calculations
gamma_e = tau_p / G;
gamma_u = gamma_e * delta_u / delta_e;
gamma_p = gamma_u -gamma_e;

% Load applied
P = 5000; %lbs/in

% Calculations for tau_avg and joint strength
lambda = sqrt((2 * G ./ ta) .* ((1 / (E0 * t1)) + (1 / (E0 * t2)))); %in^-1
L_practical_design = (P / (2 * tau_p)) + (2 ./ lambda); %in
tau_avg = (2 ./ (L_practical_design .* sqrt((1 / (E0 * t1)) + (1 / (E0 * t2))))) .* sqrt(tau_p .* ta .* ((gamma_e / 2) + gamma_p)); %psi
joint_strength = w .* tau_avg .* L_practical_design; %lbs

% Calculation for FS in shear
FS_shear = tau_u ./ tau_avg;

% Calculation for peel stress
sigma_c_max = tau_p .* (3 * Ec * (1 - nu^2) * t2 ./ (E0 .* ta)).^(1 / 4);

% Print results
fprintf('\nResults for each adhesive thickness (ta):\n');
fprintf('-----------------------------------------------------------\n');
fprintf('ta (in) | L_design (in) | Strength (lbs) | FS_shear | Peel Stress (psi)\n');
fprintf('-----------------------------------------------------------\n');
for i = 1:length(ta)
    fprintf('%.4f  |  %.4f      |  %.2f        |  %.2f   |  %.2f\n', ...
            ta(i), L_practical_design(i), joint_strength(i), FS_shear(i), sigma_c_max(i));
end
fprintf('-----------------------------------------------------------\n\n');

% Create plots
figure(1)
plot(ta, joint_strength, '-o', 'LineWidth', 2, 'MarkerSize', 8)
xlabel('Adhesive Thickness, t_a (in)')
ylabel('Joint Strength (lbs)')
title('Joint Strength vs Adhesive Thickness')
grid on

% Create plots
figure(2)
plot(ta, L_practical_design, '-o', 'LineWidth', 2, 'MarkerSize', 8, 'Color', 'c')
xlabel('Adhesive Thickness, t_a (in)')
ylabel('Most Efficient Joint Length (in)')
title('Most Efficient Joint Length vs Adhesive Thickness')
grid on

figure(3)
plot(ta, FS_shear, '-o', 'LineWidth', 2, 'MarkerSize', 8, 'Color', 'r')
xlabel('Adhesive Thickness, t_a (in)')
ylabel('FS in Shear')
title('FS Shear vs Adhesive Thickness')
grid on

figure(4)
plot(ta, sigma_c_max, '-o', 'LineWidth', 2, 'MarkerSize', 8, 'Color', 'g')
xlabel('Adhesive Thickness, t_a (in)')
ylabel('Peel Stress \sigma_c (psi)')
title('Peel Stress vs Adhesive Thickness')
grid on
