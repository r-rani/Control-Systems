% clear all;

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

P(1,1)=Jb1*Rm/km;
P(2,1)=Jb2*Rm/km;
P(3,1)=(Rm/km)*b1+km;
P(4,1)=b2*Rm/km;
P(5,1)=m2*g*l2*Rm/km;
P(6,1)=m2*L1*l2*Rm/km;


q10 = 0;
q20 = 0;
q1dot0 =0.1;
q2dot0 = -0.1;
X0= [q10; q20-pi/10; q1dot0; q2dot0];

%Params for the input
A1 = 0.1;
Af1 = 10;
A2 = 0.1;
Af2 = 20;
A3 = 0.1;
Af3 = 50;
k = 4;

sum_amps = [1 1 1 1 1 1];
sum_freqs = 2*pi*[0.5 0.8 1 1.5 2 3];
sum_gains = [0.2 0.2 0.3 0.2 0.2 0.2];


