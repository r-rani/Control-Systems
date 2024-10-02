
x = out.Lab1_Task3;
y = out.Lab1_Task;
z = out.Lab1_Task7;


plot(z(:,1),z(:,2),'y'); %graph for lab 1 task 6 and 7
hold on
plot(z(:,1),z(:,3),'b'); %graph for lab 1 task 7
hold on
plot(z(:,1),z(:,4),'r'); %graph for lab 1 task 7
hold on
plot(z(:,1),z(:,5),'g'); %graph for lab 1 task 7
hold off
xlabel('Time'), ylabel('Position/Velocity')
title('Time vs Position/Velocity');
set(gca,'color',[0.5 0.5 0.5])


%{
subplot(2,1,1);
plot(x(:,1),x(:,2)); %graph for lab 1 task 3
xlabel('Time'), ylabel('Position')
title('Time vs Position (With Approximation at Pi)');

subplot(2,1,2);
plot(x(:,1),x(:,3)); %graph for lab 1 task 3
xlabel('Time'), ylabel('Velocity')
title('Time vs Velocity (With Approximation at Pi)');
%}

%{
subplot(2,1,1);
plot(y(:,1),y(:,2)); %graph for lab 1 task 3
xlabel('Time'), ylabel('Position')
title('Time vs Position (Without Approximation at Pi)');
ylim([3.1 3.2]);

subplot(2,1,2);
plot(y(:,1),y(:,3)); %graph for lab 1 task 3
xlabel('Time'), ylabel('Velocity')
title('Time vs Velocity (Without Approximation at Pi)');
ylim([-0.1 0.1]);
%}







