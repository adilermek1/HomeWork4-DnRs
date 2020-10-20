clc
clear all
close all
fprintf('Forward Kinematics')
L1 =1;
L2 =1;
L3 =1;
L = [L1 L2 L3];
%L3 =1;
% initial angles 
q_initial = [30*pi/180 60*pi/180 30*pi/180];
% Forward kinematics 
T = FK_hw4(q_initial,L)
% robot figure 
draw_robot(q_initial,L);

T1 = T1_RRR(q_initial)
T2 = T2_RRR(q_initial,L)
T3 = T3_RRR(q_initial,L)

fprintf('Findind the Jacobian')
syms q11 q22 q33 L11 L22 L33
q_test1 = [q11 q22 q33];
L1 = [L11 L22 L33];

T_analitycal = FK_hw4(q_test1,L1)

T1 = T1_RRR(q_test1);
T2 = T2_RRR(q_test1,L1);
T3 = T3_RRR(q_test1,L1);
T4 = T4_RRR(q_test1,L1);

z0 = [T1(1,3);T1(2,3);T1(3,3)];
z1 = [T2(1,3);T2(2,3);T2(3,3)];
z2 = [T3(1,3);T3(2,3);T3(3,3)];

Oc = [T_analitycal(1,4);T_analitycal(2,4);T_analitycal(3,4)];
O0 = [T1(1,4);T1(2,4);T1(3,4)];
O1 = [T2(1,4);T2(2,4);T2(3,4)];
O2 = [T3(1,4);T3(2,4);T3(3,4)];

Jacobian_analitycal = [cross(z0,Oc-O0) cross(z1,Oc-O1) cross(z2,Oc-O2);z0 z1 z2]

T11 = T1_RRR(q_initial);
T22 = T2_RRR(q_initial,L);
T33 = T3_RRR(q_initial,L);

z00 = [T11(1,3);T11(2,3);T11(3,3)];
z11 = [T22(1,3);T22(2,3);T22(3,3)];
z22 = [T33(1,3);T33(2,3);T33(3,3)];

Occ = [T(1,4);T(2,4);T(3,4)];
O00 = [T11(1,4);T11(2,4);T11(3,4)];
O11 = [T22(1,4);T22(2,4);T22(3,4)];
O22 = [T33(1,4);T33(2,4);T33(3,4)];

Jacobian = [cross(z00,Occ-O00) cross(z11,Occ-O11) cross(z22,Occ-O22);z00 z11 z22]

