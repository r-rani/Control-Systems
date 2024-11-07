Ts = 0.002;
m1=0.095; 
m2=0.024;
L1= 0.1;
L2= 0.129;
l1 =L1/2;
l2 =L2/2;
g= 9.81;
J1 = (1/12)*m1*L1^2;
J2 = (1/12)*m2*L2^2;
Rm=8.4;
km= 0.042;
b1= 0.001;
b2 = 1e-5;

Jb1 = J1+m1*l1^2+m2*L1^2;
Jb2 = J2+m2*l2^2;

%x0 = [0; pi ; 0; 0];
q20 = pi;

%P = Rm/km*[Jb1; Jb2; (b1+(km^2/Rm)); b2; (m2*g*l2); (m2*L1*l2)];
Ph = [0.0351; 0.0143; 0.0583; 0.0011; 1.7577; 0.0155];
X0 = [0 pi+0.1 0 0];
Ts = 0.002;

M = [Ph(1) Ph(6)*cos(q20); Ph(6)*cos(q20) Ph(2)];
F = [Ph(3) 0; 0 Ph(4)];
K = [0 0; 0 Ph(5)*cos(q20)];
T = [1;0];

M_inv = inv(M);

L = -M_inv*K;
I = -M_inv*F;
N = M_inv*T;


A = [0 0 1 0; 0 0 0 1; L(1,1) L(1,2) I(1,1) I(1,2); L(2,1) L(2,2) I(2,1) I(2,2)];
B = [0;0;N(1);N(2)];

temp1 = eig(A)
poles_pi = [-6 -10 -11 -13]; %poles at pi
%poles_pi = [(14.6150 - 40) (-16.3051 - 5) (0 - 20) (-1.6433 - 21)];
%poles_zero = [-0.8272+15.2496i -0.8272-15.2496i -2 -1.6790];
Kf = place(A,B,poles_pi);
temp = eig(A - (B*Kf));


%{
C = [(B) (A*B) (A*A*B) (A*A*A*B)];

r = rank(C); %Full rank for both equilbiruim points

rand = eig(A)

k = [-8 -6 -4 -2];
poles = place(A,B,k);

temp = eig(A - (B*poles));

%}



