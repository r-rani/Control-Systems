m1=1;
b1=10;
k1=100;
m2=1;
b2=10;
k2=200;
b3=1;
k3=80;
f=50;


A= [0 1 0 0; -(k1+k2)/m1 -(b1+b2)/m1 k2/m1 b2/m1; 0 0 0 1; k2/m2 b2/m2 -(k2+k3)/m2 -(b2+b3)/m2];
B=[0;0;0;1];
C = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1]; 
D = [0; 0; 0; 0];
x0 = [1; 0.2; -0.2; 0];

t_step = 2;
f = 50; 
