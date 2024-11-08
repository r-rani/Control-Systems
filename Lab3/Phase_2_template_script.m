% Phase_2_script.m

% Task 1: Extract data from Simulink (Phase2_Model.slx) Experiment
q = qm_sim(:,2:3);
q1 = q(:,1);
q2 = q(:,2);
u = um_sim(:,2);
t = um_sim(:,1);
ufirst = u(1:10001);
usecond = u(10002:20001);

% Other data

q_est = qm(:,2:3);
q1_est = q(:,1);
q2_est = q(:,2);
u_est = um(:,2);
ufirst_L = u_est(1:10001);
usecond_L = u_est(10002:20001);

%% 


% Task 2: Estimate velocity and acceleration (First Order Approximation)
% HINT: You can use the "filter" function

% **********************  Your Code Here ********************** %
Ts = 0.002;
%q_d = velocity q_dd = acceleration 
q1_d = zeros(size(q1));
q1_dd = zeros(size(q1));
q2_d = zeros(size(q2));
q2_dd = zeros(size(q2));

%calculate velocity (start at 2 since q(k-1(
for k = 2:length(q1)
    q1_d(k) = (q1(k) - q1(k-1)) / Ts;
    q2_d(k) = (q2(k) - q2(k-1)) / Ts;
end
%acceleration. Start 3 since q_d(k-1)
for k = 3:length(q1)
    q1_dd(k) = (q1_d(k) - q1_d(k-1)) / Ts;
    q2_dd(k) = (q2_d(k) - q2_d(k-1)) / Ts;
end


tiledlayout(1,3)
nexttile
plot(t, q1);
title("Position of Joint 1 (rads)");
xlabel("Seconds");
ylabel("Radians");
nexttile
plot(t, q1_d);
title("Velocity of Joint 1 rad/s");
xlabel("Seconds");
ylabel("Radians");
nexttile
plot(t,q1_dd);
title("Acceleration of Joint 1 rad/s^2");
xlabel("Seconds");
ylabel("Radians");
%% 



% Task 3: Estimate velocity and acceleration (Discrete-time Differentiator)

% Filter parameters
filt_order = 22;
Ts = 0.002;

% Create a MATLAB digitalFilter object
d_filt = designfilt('differentiatorfir', ... % Response type
       'FilterOrder',filt_order, ...            % Filter order
       'PassbandFrequency',5, ...     % Frequency constraints
       'StopbandFrequency',8, ...
       'DesignMethod','equiripple', ... % Design method
       'PassbandWeight',1, ...          % Design method options
       'StopbandWeight',4, ...
       'SampleRate',1/Ts);

% **********************  Your Code Here ********************** %
%lag
lag = (filt_order/2)+1;
% Plot frequency response of the filter
figure;
freqz(d_filt);
title('Frequency Response of the FIR Differentiator');
%% 

%velocity filtered 
q1_d_filtered = filter(d_filt, q1);
q1_d_filtered = q1_d_filtered(lag:length(q1_d_filtered));
q2_d_filtered = filter(d_filt, q2);
q2_d_filtered = q2_d_filtered(lag:length(q2_d_filtered));
%Acceleration filtered
q1_dd_filtered = filter(d_filt, q1_d_filtered);
q1_dd_filtered = q1_dd_filtered(lag:length(q1_dd_filtered));
q2_dd_filtered = filter(d_filt, q2_d_filtered);
q2_dd_filtered = q2_dd_filtered(lag:length(q2_dd_filtered));
t_lag_d = t(lag:length(t));
t_lag_dd = t_lag_d(lag:length(t_lag_d));
tiledlayout(2,3)
nexttile
plot(t, q1);
title("Position of Joint 1 rads");
xlabel("Seconds");
ylabel("Radians");
nexttile
plot(t_lag_d, q1_d_filtered);
title("Velocity of Joint 1 rad/s");
xlabel("Seconds");
ylabel("Radians");
nexttile
plot(t_lag_dd,q1_dd_filtered);
title("Acceleration of Joint 1 rad/s^2");
xlabel("Seconds");
ylabel("Radians");
nexttile
plot(t, q2);
title("Position of Joint 2 rads");
xlabel("Seconds");
ylabel("Radians");
nexttile
plot(t_lag_d, q2_d_filtered);
title("Velocity of Joint 2 rad/s");
xlabel("Seconds");
ylabel("Radians");
nexttile
plot(t_lag_dd,q2_dd_filtered);
title("Acceleration of Joint 2 rad/s^2");
xlabel("Seconds");
ylabel("Radians");
%% 

% Task 4: Comparisons

% **********************  Your Code Here ********************** %

tiledlayout(4,2);
nexttile
plot(t, q1_d);
title("Velocity of Joint 1 rad/s - Unfiltered");
xlabel("Seconds");
ylabel("Radians");
nexttile
plot(t_lag_d, q1_d_filtered);
title("Velocity of Joint 1 rad/s - Filtered");
xlabel("Seconds");
ylabel("Radians");
nexttile
plot(t,q1_dd);
title("Acceleration of Joint 1 rad/s^2 - Unfiltered");
xlabel("Seconds");
ylabel("Radians");
nexttile
plot(t_lag_dd,q1_dd_filtered);
title("Acceleration of Joint 1 rad/s^2 - Filtered");
xlabel("Seconds");
ylabel("Radians");
nexttile
plot(t, q2_d);
title("Velocity of Joint 2 rad/s - Unfiltered");
xlabel("Seconds");
ylabel("Radians");
nexttile
plot(t_lag_d, q2_d_filtered);
title("Velocity of Joint 2 rad/s - Filtered");
xlabel("Seconds");
ylabel("Radians");
nexttile
plot(t,q2_dd);
title("Acceleration of Joint 2 rad/s^2 - Unfiltered");
xlabel("Seconds");
ylabel("Radians");
nexttile
plot(t_lag_dd,q2_dd_filtered);
title("Acceleration of Joint 2 rad/s^2 - Filtered");
xlabel("Seconds");
ylabel("Radians");

%% 
% Task 5: Least Squares Estimation
% HINT: Make sure to account for the time-lag of the differentiator

% **********************  Your Code Here ********************** %
n = length(q1);
n_5 = 0;
n_6 = 0;
if n%2=1
    n_5 = round(n/2);
    n_6 = round(n/2)-1;
else
    n_5 = n/2;
    n_6 = n/2;
end

%% 

q1_5= transpose(q1(1:n_5));
q2_5=transpose(q2(1:n_5));
q1_d_5= transpose(q1_d_filtered(1:n_5));
q2_d_5= transpose(q2_d_filtered(1:n_5));
q1_dd_5= transpose(q1_dd_filtered(1:n_5));
q2_dd_5= transpose(q2_dd_filtered(1:n_5));
%% 

Y = [q1_5; q2_5; q1_d_5; q2_d_5; q1_dd_5; q2_dd_5]; %2m x 6 
Y = transpose(Y);
%% 

%calculate P hat which is the vector of paramters Phat = 
Y_T = transpose(Y); %6xn_5
%% 
Y_T_Y = Y_T * Y; %6xn_5 * n_5*6 = 6x6
%% 
inv_YTY = inv (Y_T_Y); %6x6
Y_T_U = Y_T * ufirst; %6xn_5 * n_5x1 = 6x1 * 
Phat = inv_YTY*Y_T_U; %supposed to by 6 x 1
%% 

% Task 6: Compute Model Prediction Error

% **********************  Your Code Here ********************** %
q1_6= transpose(q1(1:n_6));
q2_6= transpose(q2(1:n_6));
q1_d_6=transpose(q1_d_filtered(1:n_6));
q2_d_6=transpose(q2_d_filtered(1:n_6));
q1_dd_6=transpose(q1_dd_filtered(1:n_6));
q2_dd_6=transpose(q2_dd_filtered(1:n_6));

Y_6 = [q1_6; q2_6; q1_d_6; q2_d_6; q1_dd_6; q2_dd_6]; %2m x 6 so transpose
Y_6 = transpose(Y_6); %n_6x6
%% 

U_squig = Y_6 * Phat - usecond; %n_6x6 *6x1 - n_6x1 = n_6x1
 
sum_U_squig = 0;
sum_U = 0;
for k = 1: n_6-1
    sum_U_squig = sum_U_squig + (U_squig(k))^2;
    sum_U = sum_U + (usecond(k))^2;
end

PE= sqrt(sum_U_squig/sum_U);

%comparing values graph 

%% 

% Task 7: Compute Percentage Parameter Estimation Error

% **********************  Your Code Here ********************** %

p_i_squig = [0 0 0 0 0 0]; %percentage parameter estimation


for i = 1:6
    abs_val = abs(P(i)-Phat(i)); 
    p_i_squig(i) = (abs_val/P(i))*100;
end
%% 

% Task 8-10 
%% Least Squares Estimation 
n_L = length(q1_est);
n_5_L = 0;
n_6_L = 0;
if n_L%2=1
    n_5_L = round(n_L/2);
    n_6_L= round(n_L/2)-1;
else
    n_5_L = n_L/2;
    n_6_L = n_L/2;
end

%velocity filtered 
q1_d_filtered_L = filter(d_filt, q1_est);
q1_d_filtered_L = q1_d_filtered_L(lag:length(q1_d_filtered_L));
q2_d_filtered_L = filter(d_filt, q2_est);
q2_d_filtered_L = q2_d_filtered_L(lag:length(q2_d_filtered_L));
%Acceleration filtered
q1_dd_filtered_L = filter(d_filt, q1_d_filtered_L);
q1_dd_filtered_L = q1_dd_filtered_L(lag:length(q1_dd_filtered_L));
q2_dd_filtered_L = filter(d_filt, q2_d_filtered_L);
q2_dd_filtered_L = q2_dd_filtered_L(lag:length(q2_dd_filtered_L));

q1_5_L= transpose(q1_est(1:n_5_L));
q2_5_L=transpose(q2_est(1:n_5_L));
q1_d_5_L= transpose(q1_d_filtered_L(1:n_5_L));
q2_d_5_L= transpose(q2_d_filtered_L(1:n_5_L));
q1_dd_5_L= transpose(q1_dd_filtered_L(1:n_5_L));
q2_dd_5_L= transpose(q2_dd_filtered_L(1:n_5_L));


Y_L = [q1_5_L; q2_5_L; q1_d_5_L; q2_d_5_L; q1_dd_5_L; q2_dd_5_L]; %2m x 6 
Y_L = transpose(Y_L);
Y_T_L = transpose(Y_L); %6xn_5
Y_T_Y_L = Y_T_L * Y_L; %6xn_5 * n_5*6 = 6x6
inv_YTY_L = inv (Y_T_Y_L); %6x6
Y_T_U_L = Y_T_L * ufirst_L; %6xn_5 * n_5x1 = 6x1 * 
Phat_L = inv_YTY_L*Y_T_U_L; %supposed to by 6 x 1
%% Task 6 
q1_6_L= transpose(q1_est(1:n_6_L));
q2_6_L= transpose(q2_est(1:n_6_L));
q1_d_6_L=transpose(q1_d_filtered_L(1:n_6_L));
q2_d_6_L=transpose(q2_d_filtered_L(1:n_6_L));
q1_dd_6_L=transpose(q1_dd_filtered_L(1:n_6_L));
q2_dd_6_L=transpose(q2_dd_filtered_L(1:n_6_L));

Y_6_L = [q1_6_L; q2_6_L; q1_d_6_L; q2_d_6_L; q1_dd_6_L; q2_dd_6_L]; %2m x 6 so transpose
Y_6_L = transpose(Y_6_L); %n_6x6
U_squig_L = Y_6_L * Phat_L - usecond_L; %n_6x6 *6x1 - n_6x1 = n_6x1
 
sum_U_squig_L = 0;
sum_U_L = 0;
for k = 1: n_6_L-1
    sum_U_squig_L = sum_U_squig_L + (U_squig_L(k))^2;
    sum_U_L = sum_U_L + (usecond_L(k))^2;
end

PE_L= sqrt(sum_U_squig_L/sum_U_L);

