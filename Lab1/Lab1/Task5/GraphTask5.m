%Graphs for Task 5
z = out.Lab1_Task5;

plot(z(:,1),z(:,2),'y'); %graph for lab 1 task 7
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

