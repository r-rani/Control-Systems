%%Task 2 
%sample time 
T_s = 0.01;
t = 0:T_s:10; %10 seconds

%sample data from online of pendulumn, replace w real shi
q1 = 10 * exp(-0.1 * t) .* sin(2 * pi * 0.5 * t) + 0.1 * randn(size(t));  % Position with noise
q2 = 10 * exp(-0.1 * t) .* sin(2 * pi * 0.5 * t) + 0.1 * randn(size(t));  % Position with noise

%q_d = velocity q_dd = acceleration 
q1_d = zeros(size(q1));
q1_dd = zeros(size(q1));
q2_d = zeros(size(q2));
q2_dd = zeros(size(q2));

%calculate velocity (start at 2 since q(k-1(
for k = 2:length(q1)
    q1_d(k) = (q1(k) - q1(k-1)) / T_s;
    q2_d(k) = (q2(k) - q2(k-1)) / T_s;
end
%acceleration. Start 3 since q_d(k-1)
for k = 3:length(q1)
    q1_dd(k) = (q1_d(k) - q1_d(k-1)) / T_s;
    q2_dd(k) = (q2_d(k) - q2_d(k-1)) / T_s;
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




%% Task 3
%copied from lab
d_filt = designfilt('differentiatorfir', ...
    'FilterOrder', 22, ...        % Filter order (higher order gives better differentiation but may introduce more delay)
    'PassbandFrequency', 5, ...   % Passband frequency (Hz)
    'StopbandFrequency', 8, ...   % Stopband frequency (Hz)
    'DesignMethod', 'equiripple', ...  % Design method: Equiripple
    'PassbandWeight', 1, ...
    'StopbandWeight', 4, ...
    'SampleRate', 1/T_s);         % Sampling rate in Hz

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
%% Task 4
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
%% Task 5
%length of the data set for this is half the length of q1. first half in
%this task and second half in the other tasks 
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
q1_5= q1(1:n_5);
q2_5=q2(1:n_5);
q1_d_5=q1_d(1:n_5);
q2_d_5=q2_d(1:n_5);
q1_dd_5=q1_dd(1:n_5);
q2_dd_5=q2_dd(1:n_5);

Y = [q1_5; q2_5; q1_d_5; q2_d_5; q1_dd_5; q2_dd_5]; %2m x 6 so transpose
Y = transpose(Y);
U = transpose(randi([1, 5], 1, n_5));  %random values bw 1-5 (im assuming 5 V input) transpose so stacked

%calculate P hat which is the vector of paramters Phat = 
Y_T = transpose(Y); %6xn_5
Y_T_Y = Y_T * Y; %6
inv_YTY = inv (Y_T_Y); %n_5 x n_5
Y_T_U = Y_T * U; %n_5 x 6 * 
Phat = inv_YTY*Y_T_U; %supposed to by 6 x 1
%% Task 6
q1_6= q1(1:n_6);
q2_6=q2(1:n_6);
q1_d_6=q1_d(1:n_6);
q2_d_6=q2_d(1:n_6);
q1_dd_6=q1_dd(1:n_6);
q2_dd_6=q2_dd(1:n_6);

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

%% Task 7
p_i_squig = zeros(6); %percentage parameter estimation
p_i = zeros(6); %correct parameters ?? how do I know 

for i = 1:6
    p_i_squig = (abs(p_i(i)-Phat(i))/p_i(i))*100;
end


