% Phase_2_script.m

% Task 1: Extract data from Simulink (Phase2_Model.slx) Experiment

q = qm(:,2:3);
u = um(:,2);
t = um(:,1);


% Task 2: Estimate velocity and acceleration (First Order Approximation)
% HINT: You can use the "filter" function

% **********************  Your Code Here ********************** %


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


% Task 4: Comparisons

% **********************  Your Code Here ********************** %


% Task 5: Least Squares Estimation
% HINT: Make sure to account for the time-lag of the differentiator

% **********************  Your Code Here ********************** %


% Task 6: Compute Model Prediction Error

% **********************  Your Code Here ********************** %


% Task 7: Compute Percentage Parameter Estimation Error

% **********************  Your Code Here ********************** %


% Task 8-10 
% % ...






