% Define symbolic variables
syms q1 q2 dq1 dq2 u real % q1, q2 are positions; dq1, dq2 are velocities
syms J1 J2 m2 L1 l2 g b1 b2 km Rm real % System parameters

% Inertia Matrix D(q)
D = [J1 + J2*sin(q2)^2, m2*L1*l2*cos(q2);
     m2*L1*l2*cos(q2),    J2];

% Inverse of D(q)
D_inv = inv(D);

% Nonlinear term N(q, dq)
N1 = -m2*L1*l2*sin(q2)*dq2^2 + J2*sin(2*q2)*dq1*dq2 + (b1 + (km^2/Rm))*dq1;
N2 = -(1/2)*J2*sin(2*q2)*dq1^2 + b2*dq2 + m2*g*l2*sin(q2);

N = [N1; N2];

% Input voltage term
U = [km/Rm * u; 0];

% Accelerations in terms of states and input
ddq = D_inv * (U - N);

% Define state vector
x = [q1; q2; dq1; dq2];

% Derivatives of the state equations (for linearization)
A = jacobian([dq1; dq2; ddq], x); % Jacobian w.r.t. state variables
B = jacobian([dq1; dq2; ddq], u); % Jacobian w.r.t. input

% Simplify and display A and B matrices
A = simplify(A);
B = simplify(B);

disp('A Matrix:');
disp(A);

disp('B Matrix:');
disp(B);
