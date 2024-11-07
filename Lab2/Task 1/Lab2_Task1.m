u=1;
x(1)=1;
x(2)=1;
x(3)=1;
x(4)=1;


m1 = 0.095;
m2 = 0.024;   % M2
L1 = 0.1;   % length L1
L2 = 0.129;   % L2 lenght to center of amss
J1 = (1/12)*m1*L1^2;  % Inertia L1
J2 = (1/12)*m2*L2^2;  % Int L2
g = 9.81;   %grav
b1 = 0.001;   % Damping J1
b2 = 0.00001;   % Dampin J2
km = 0.042;  % Motor torque constant
Rm = 8.4;   % Motor resistance
%u = 0; % Input voltage
l1 = L1/2;
l2 = L2/2;

%q variables 
q1 = x(1);   % J1 posn
q2 = x(2);   % J2 posn
dq1 = x(3);  % J1 V
dq2 = x(4);  % J2 V

%x matrix
x_q = [q1 ;q2 ;dq1; dq2];


%  D(q)
D = [J1 + J2*sin(q2)^2 m2*L1*l2*cos(q2); m2*L1*l2*cos(q2) J2];
% N(q, dq)
N1 = -m2*L1*l2*sin(q2)*dq2^2 + J2*sin(2*q2)*dq1*dq2 + (b1 + (km^2/Rm))*dq1;
N2 = -(1/2)*J2*sin(2*q2)*dq1^2 + b2*dq2 + m2*g*l2*sin(q2);
N = [N1; N2];
%U input
U = [km/Rm * u; 0];


%find ddq as shown in equation for task 1 
D_inv = inv(D);
ddq = D_inv * (U-N);
ddq1 = ddq(1) ;
ddq2= ddq(2);
dx = [dq1; dq2; ddq1; ddq2];