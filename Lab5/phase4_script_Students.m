q10 = 0;
q20 = pi;
%Ph from Phase 3
Ph = [0.0351; 0.0143; 0.0583; 0.0011; 1.7577; 0.0155];

Ts = 0.001;

X0=[0; 0.9*pi; 0; 0];

M = [Ph(1)  Ph(6)*cos(q20);
            Ph(6)*cos(q20)  Ph(2)];

F = [Ph(3)  0;
              0          Ph(4)];

K =  [0  0;
      0  Ph(5)*cos(q20)];

T1 = [1; 0];


A = [zeros(2,2)  eye(2);
     -M\K   -M\F];

B= [zeros(2,1);
    M\T1];

C=[1 0 0 0;
   0 1 0 0];



p = [-10+10j, -10-10j, -15, -18];

%% Task 1
%Compute A and B matrices (Used Ph from last lab to compute A B)
%Recompute the state feedback gain K using the pole placements Procedure
%Is it contorllable ?
PC = [(B) (A*B) (A*A*B) (A*A*A*B)];
r = rank(PC); %Full rank for both equilbiruim points
%k
K = place(A, B, p);
%verification 
p_cl = transpose(eig(A-B*K));
%poles = poles_closedLoop
%% Task 2
%Compute obsv matrix
PO = [(C); (C*A); (C*A*A); (C*A*A*A)];
ro = rank(PO);
%rank of observability matrix is full (4)
%% Task3
%Observer Poles. Chose Random ones. pe is supposed to be faster so set the
%value higher 
pe = [-20, -21, -25, -28];
%find L based on Observer Poles 
L_T = place(transpose(A), transpose(C), obsv_poles);
L = transpose(L_T);

u=-K*x;


