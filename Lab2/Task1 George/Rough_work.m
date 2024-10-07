x = [1,2,3,4];
u = 4;

m1 = 1;
m2 = 1;
J1 = 1;
J2 = 1;
l1 = 1;
l2 = 1;
L1 = 1;
L2 = 1;
g = 9.81;
b1 = 0;
b2 = 0;
km = 1;
rm = 1;

x1 = x(1); %q1
x2 = x(2); %q2
x3 = x(3); %q1_dot
x4 = x(4); %q2_dot

J1_prime = J1 + m1*((l1)^2) + m2*((L1)^2);
J2_prime = J2 + m2*((l2)^2);

d11 = (J1_prime) + ((J2_prime)*(sin(x2)^2));
d12 = (m2*L1*l2*cos(x2));
d21 = d12;
d22 = J2_prime;

d = [d11 d12; d21 d22];
d_inv = inv(d);

dx1 = x3;
dx2 = x4;

n1 = -(m2*L1*l2*sin(x2)*x4 + J2_prime*sin(2*x2)*x3*x4 + (b1 + ((km^2)/rm))*x3);

n2 = -(1/2*J2_prime*sin(2*x2)*((x3)^2) + b2*x3 + (m2*g*l2*sin(x2)));

z_den = ((J1_prime*J2_prime) + (((J2_prime)^2)*(sin(x2)^2)) - (((m2*L1*l2*cos(x2))^2)));

z1 = J2_prime / z_den;
z2 = - ((m2*L1*l2*cos(x2)) / z_den);
z3 = - ((m2*L1*l2*cos(x2)) / z_den);
z4 = (J1_prime) + ((J2_prime)*(sin(x2)^2));

%A= [0 1 0 0; -(k1+k2)/m1 -(b1+b2)/m1 k2/m1 b2/m1; 0 0 0 1; k2/m2 b2/m2 -(k2+k3)/m2 -(b2+b3)/m2];
%B=[0;0;0;1];

%{
dx3 = (z1*((km/rm)-u-n1)) + z2*n2;
dx4 = (z3*((km/rm)-u-n1)) + z4*n2;
%}

dx3 = (d_inv(1,1)*((km/rm)-u-n1)) + d_inv(1,2)*n2;
dx4 = (d_inv(2,1)*((km/rm)-u-n1)) + d_inv(2,2)*n2;

sys = [dx1 dx2 dx3 dx4];
