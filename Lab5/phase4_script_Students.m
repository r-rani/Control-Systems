q10 = 0;
q20 = pi;
%Ph from Phase 3

%Ph = [0.0326; 0.0108; 0.0583; 0.0011; 1.7577; 0.0155];
Ph = [0.0326046514030132, 0.0108027150698210, 0.0598312321859148, 0.000850806189370570, 1.29866678626179, 0.0128036388307211];
%Ph = load("ph_device_06.mat","-mat");

Ts = 0.001;

X0=[0; 0.95*pi; 0; 0];

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

poles_A = poly(eig(A));
new_char = poly(p);
r = rank(PC); %Full rank for both equilbiruim points

PC = [(B) (A*B) (A*A*B) (A*A*A*B)];
A_2 = [0 1 0 0; 0 0 1 0; 0 0 0 1; -poles_A(5) -poles_A(4) -poles_A(3) -poles_A(2)];
B_2 = [0; 0; 0; 1];

PC_2 = [(B_2) (A_2*B_2) (A_2*A_2*B_2) (A_2*A_2*A_2*B_2)];
r_2 = rank(PC_2);

T = PC*inv(PC_2);
T_inv = inv(T);

Kc = [new_char(5)-poles_A(5), new_char(4)-poles_A(4), new_char(3)-poles_A(3), new_char(2)-poles_A(2)];
K_2 = Kc*T_inv;
%k
%K = place(A, B, p);
%verification 
p_cl = transpose(eig(A-B*K_2));
%poles = poles_closedLoop
%% Task 2
%Compute obsv matrix
PO = [(C); (C*A); (C*A*A); (C*A*A*A)];
ro = rank(PO);
%rank of observability matrix is full (4)
%% Task3
%Observer Poles. Chose Random ones. pe is supposed to be faster so set the
%value higher 
pe = [32*p];
%find L based on Observer Poles 
L_T = place(transpose(A), transpose(C), pe);
L = transpose(L_T);
p_o = transpose(eig(A-L*C)); %see poles

%u=-K*x;

%% Task5 and 6
A_sim = A-L*C;
B_sim = [B L];
C_sim = eye(4);
D_sim = zeros(4,3);

