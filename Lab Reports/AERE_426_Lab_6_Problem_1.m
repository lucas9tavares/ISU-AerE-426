% AerE 426, Lab Assignment 6 - Joint Design: Problem 1, Lucas Tavares

clear, clc, close all

% Define bolts positions (from gusset plate's bottom left corner)
bolts_coords = [[1, 5]; [3, 5]; [5, 5]; [7, 5]; [2, 3]; [4, 3]; [6, 3]; [1, 1]; [3, 1]; [5, 1]; [7, 1]]; %in

% Calculate mean X and Y (since D is constant among all bolts)
X_bar = sum(bolts_coords(:,1)) ./ length(bolts_coords);
Y_bar = sum(bolts_coords(:,2)) ./ length(bolts_coords);


% Diameter assumed arbitrarily
D = 3/8; %in

% Calculate moment of inertia
I = sum(D * bolts_coords(:,1).^2) + sum(D * bolts_coords(:,2).^2) - X_bar * sum(D * bolts_coords(:,1)) - Y_bar * sum(D * bolts_coords(:,2));

% Applied loads with FS = 5
P_x = 5 * 1750; %lbs
P_y = 5 * 1250; %lbs

% Moment at centroid (X_bar, Y_bar) (positive counterclockwise)
M = P_x * Y_bar + P_y * (20 - X_bar); %lbs*in

% Calculate load at each rivet
P = D .* sqrt(((P_y / (D * length(bolts_coords))) + (M .* (bolts_coords(:,1) - X_bar) ./ I)).^2 + ((P_x / (D * length(bolts_coords))) + (M .* (bolts_coords(:,2) - Y_bar) ./ I)).^2); %lbs

% Retrieve maximum load at rivets
P_max = max(P); %lbs
fprintf('\nMax load at joints: %.4f lbs\n\n', P_max)

% From table, chose rivet with 5/16 in and A-286 material; F_rivet = 7375
% lbs
D = 5/16; %in
F_rivet = 7375; %lbs

% Max load at joints without FS of 5
P_max_actual = P_max / 5; %lbs
fprintf('Actual max load at joints: %.4f lbs\n\n', P_max_actual)

% Calculate the FS for the rivet
FS_rivet = F_rivet / P_max_actual;
fprintf('FS_rivet: %.4f \n\n', FS_rivet)

% Minimum distance between rivet hole and wall e
e = 1; %in

e_over_D = e / D;
fprintf('e/D: %.4f \n\n', e_over_D)

% From table, F_bearing_yield = 346 ksi
F_bearing_yield = 346000; %psi

% Calculate allowable P for bearing
t = 3 / 8; %in
P_allowable_bearing = F_bearing_yield * D * t; %lbs

% Calculate FS for bearing
FS_bearing = P_allowable_bearing / P_max_actual;

fprintf('FS_bearing: %.4f \n\n', FS_bearing)
