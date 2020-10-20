clc
clear all 
close all
fprintf('Finding the first joint parameter')  
M = Matrix_RRR(0,2);
q01 = 0;
qf1 = 2;
P = Parameters_RRR(q01,0,0,qf1,0,0);
Par1 = inv(M)*P;
syms t 
fprintf('Polynomial function for the first joint')
f1 = Par1(1) + Par1(2)*t + Par1(3)*t^2 + Par1(4)*t^3 + Par1(5)*t^4 + Par1(6)*t^5

t = 0:0.01:2;
f11 = Par1(1) + Par1(2)*t + Par1(3)*t.^2 + Par1(4)*t.^3 + Par1(5)*t.^4 + Par1(6)*t.^5;
f11_v = Par1(2) + 2*Par1(3)*t + 3*Par1(4)*t.^2 + 4*Par1(5)*t.^3 + 5*Par1(6)*t.^4;
f11_a = 2*Par1(3) + 6*Par1(4)*t + 12*Par1(5)*t.^2 + 20*Par1(6)*t.^3;
figure(1) 
plot(t,f11)
grid on 
title('First joint parameter vs time')
xlabel('time')
ylabel('angle')

fprintf('Finding the second joint parameter')
q02 = 0;
qf2 = 3;
P = Parameters_RRR(q02,0,0,qf2,0,0);
Par2 = inv(M)*P;
syms t 
fprintf('Polynomial function for the second joint')
f2 = Par2(1) + Par2(2)*t + Par2(3)*t^2 + Par2(4)*t^3 + Par2(5)*t^4 + Par2(6)*t^5

t = 0:0.01:2;
f22 = Par2(1) + Par2(2)*t + Par2(3)*t.^2 + Par2(4)*t.^3 + Par2(5)*t.^4 + Par2(6)*t.^5;
figure(2)
plot(t,f22)
grid on
title('Second joint parameter vs time')
xlabel('time')
ylabel('angle')

fprintf('Finding the third joint parameter')
q03 = 0;
qf3 = 4;
P = Parameters_RRR(q03,0,0,qf3,0,0);
Par3 = inv(M)*P;
syms t 
fprintf('Polynomial function for the second joint')
f3 = Par3(1) + Par3(2)*t + Par3(3)*t^2 + Par3(4)*t^3 + Par3(5)*t^4 + Par3(6)*t^5

t = 0:0.01:2;
f33 = Par3(1) + Par3(2)*t + Par3(3)*t.^2 + Par3(4)*t.^3 + Par3(5)*t.^4 + Par3(6)*t.^5;
figure(3)
plot(t,f33)
grid on
title('Third joint parameter vs time')
xlabel('time')
ylabel('angle')

figure(4)
plot(t,f11)
hold on 
plot(t,f22)
hold on 
plot(t,f33)
grid on 
title('Joint parameters vs time')
xlabel('time')
ylabel('angle')
legend ('first joint','second joint','third joint')


