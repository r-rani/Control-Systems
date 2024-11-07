
x = um;
z = qm;

plot(x(:,1),x(:,2)); %
xlabel('Time'), ylabel('Input')
title('Time vs Input');

%%
plot(z(:,1),z(:,2),'y'); %graph for lab 1 task 6 and 7
hold on
plot(z(:,1),z(:,3),'b'); %graph for lab 1 task 7
hold off
xlabel('Time'), ylabel('Position')
title('Time vs Position of q1 & q2');
set(gca,'color',[0.5 0.5 0.5])
legend('q1','q2');