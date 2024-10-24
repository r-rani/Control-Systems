% Phase_2_script.m

% Task 1: Extract data from Simulink (Phase2_Model.slx) Experiment

q = qm(:,2:3);
q1 = q(:,1);
q2 = q(:,2);
u = um(:,2);
t = um(:,1);


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
title("posn");
nexttile
plot(t, q1_d);
title("vel");
nexttile
plot(t,q1_dd);
title("acc");
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
%velocity filtered 
q1_d_filtered = filter(d_filt, q1);
q2_d_filtered = filter(d_filt, q2);
%Acceleration filtered
q1_dd_filtered = filter(d_filt, q1_d);
q2_dd_filtered = filter(d_filt, q2_d);

tiledlayout(1,3)
nexttile
plot(t, q1);
title("posn");
nexttile
plot(t, q1_d_filtered);
title("vel");
nexttile
plot(t,q1_dd_filtered);
title("acc");
%% 

% Task 4: Comparisons

% **********************  Your Code Here ********************** %

tiledlayout(2,2);
nexttile
plot(t, q1_d);
title("vel");
nexttile
plot(t, q1_d_filtered);
title("vel filt");
nexttile
plot(t,q1_dd);
title("acc");
nexttile
plot(t,q1_dd_filtered);
title("acc filt");
%% 
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

lag = (filt_order/2)+1;
q1_5= q1(1:n_5);
q2_5=q2(1:n_5);
q1_d_5=q1_d_filtered(1:n_5);
q2_d_5=q2_d_filtered(1:n_5);
q1_dd_5=q1_dd_filtered(1:n_5);
q2_dd_5=q2_dd_filtered(1:n_5);

Y = [q1_5; q2_5; q1_d_5; q2_d_5; q1_dd_5; q2_dd_5]; %2m x 6 so transpose
Y = transpose(Y);
U = transpose(randi([1, 5], 1, n_5));  %random values bw 1-5 (im assuming 5 V input) transpose so stacked

%calculate P hat which is the vector of paramters Phat = 
Y_T = transpose(Y); %6xn_5
Y_T_Y = Y_T * Y; %6
inv_YTY = inv (Y_T_Y); %n_5 x n_5
Y_T_U = Y_T * U; %n_5 x 6 * 
Phat = inv_YTY*Y_T_U; %supposed to by 6 x 1
%% 

% Task 6: Compute Model Prediction Error

% **********************  Your Code Here ********************** %
q1_6= q1(1:n_6);
q2_6=q2(1:n_6);
q1_d_6=q1_d_filtered(1:n_6);
q2_d_6=q2_d_filtered(1:n_6);
q1_dd_6=q1_dd_filtered(1:n_6);
q2_dd_6=q2_dd_filtered(1:n_6);

Y_6 = [q1_6; q2_6; q1_d_6; q2_d_6; q1_dd_6; q2_dd_6]; %2m x 6 so transpose
Y_6 = transpose(Y_6);
U_6 = transpose(randi([1, 5], 1, n_6));  %random values bw 1-5 (im assuming 5 V input) transpose so stacked

U_squig = Y_6 * Phat - U_6; %n_6x6 *6x1 - n_6x6 = n_6x1
 
sum_U_squig = 0;
sum_U = 0;
for k = 1: n_6
    sum_U_squig = sum_U_squig + (U_squig(k))^2;
    sum_U = sum_U + (U_6(k))^2;
end

PE= sqrt(sum_U_squig/sum_U);

%comparing values graph 

%% 

% Task 7: Compute Percentage Parameter Estimation Error

% **********************  Your Code Here ********************** %

p_i_squig = zeros(6); %percentage parameter estimation
p_i = zeros(6); %correct parameters ?? how do I know 

for i = 1:6
    p_i_squig = (abs(p_i(i)-Phat(i))/p_i(i))*100;
end
%% 

% Task 8-10 
% % ...






