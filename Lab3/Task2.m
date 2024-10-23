%%Task 2 
%sample time 
T_s = 0.01;
t = 0:T_s:10; %10 seconds

%sample data from online of pendulumn, replace w real shi
q = 10 * exp(-0.1 * t) .* sin(2 * pi * 0.5 * t) + 0.1 * randn(size(t));  % Position with noise

%q_d = velocity q_dd = acceleration 
q_d = zeros(size(q));
q_dd = zeros(size(q));

%calculate velocity (start at 2 since q(k-1(
for k = 2:length(q)
    q_d(k) = (q(k) - q(k-1)) / T_s;
end
%acceleration. Start 3 since q_d(k-1)
for k = 3:length(q)
    q_dd(k) = (q_d(k) - q_d(k-1)) / T_s;
end
tiledlayout(1,3)
nexttile
plot(t, q);
title("posn");
nexttile
plot(t, q_d);
title("vel");
nexttile
plot(t,q_dd);
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
q_d_filtered = filter(d_filt, q);
%Acceleration filtered
q_dd_filtered = filter(d_filt, q_d);

tiledlayout(1,3)
nexttile
plot(t, q);
title("posn");
nexttile
plot(t, q_d_filtered);
title("vel");
nexttile
plot(t,q_dd_filtered);
title("acc");
%% Task 4
tiledlayout(2,2);
nexttile
plot(t, q_d);
title("vel");
nexttile
plot(t, q_d_filtered);
title("vel filt");
nexttile
plot(t,q_dd);
title("acc");
nexttile
plot(t,q_dd_filtered);
title("acc filt");
%% Task 5
