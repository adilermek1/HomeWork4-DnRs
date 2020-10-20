clc
clear all 
close all
M = Matrix_RRR(0,2);
q01 = 0;
qf1 = 2;
P = Parameters_RRR(q01,0,0,qf1,0,0);
Par1 = inv(M)*P;
t = 0:0.01:2;
f11 = Par1(1) + Par1(2)*t + Par1(3)*t.^2 + Par1(4)*t.^3 + Par1(5)*t.^4 + Par1(6)*t.^5;
f11_v = Par1(2) + 2*Par1(3)*t + 3*Par1(4)*t.^2 + 4*Par1(5)*t.^3 + 5*Par1(6)*t.^4;
f11_a = 2*Par1(3) + 6*Par1(4)*t + 12*Par1(5)*t.^2 + 20*Par1(6)*t.^3;

q01 = 0;
qf1 = 2;
v0 = 0;
v_max = 1;
a_max = 10;

ta = v_max/a_max
tf = (qf1-q01)/v_max + ta

t = 0:0.001:tf;
% t0 --> ta:
a10 = q01;
a11 = v0;
a12 = 0.5*a_max;
% ta -->tf-ta:
a20 = q01 + 0.5*a_max*ta^2 - v_max*ta;
a21 = v_max;

%tf-ta --> tf:
a30 = qf1 - 0.5*a_max*tf^2;
a31 = a_max*tf;
a32 = -0.5*a_max;

q = (a10+a11.*t+a12.*t.^2).*(t<=ta) + (a20 + a21.*t).*(t>ta).*(t<=(tf-ta)) + (a30 + a31.*t+a32.*t.^2).*(t>(tf-ta)).*(t<=tf);
v = (a11 +2*a12.*t).*(t<=ta)+(a21).*(t>ta).*(t<=(tf-ta))+(a31 +2*a32.*t).*(t>(tf-ta)).*(t<=tf);
a = (2*a12).*(t<=ta)+(0).*(t>ta).*(t<=(tf-ta))+(2*a32).*(t>(tf-ta)).*(t<=tf);

figure(1)
plot(t,q,'k','linewidth',3)
hold on 
line([ta ta],[q01 qf1])
line([tf-ta tf-ta],[q01 qf1])
grid on 
title ('position vs time')
axis([0 tf q01 qf1])

figure(2)
plot(t,v,'k','linewidth',3)
hold on 
line([ta ta],[0 v_max])
line([tf-ta tf-ta],[0 v_max])
title('velocity vs time')
grid on 
axis([0 tf 0 v_max])

figure(3)
plot(t,a,'k','linewidth',3)
hold on 
line ([ta ta],[-a_max a_max])
line([tf-ta tf-ta],[-a_max a_max])
title('acceleration vs time')
grid on 
axis([0 tf -a_max a_max])

delta_t = 0.01;
n=0;
while (floor(delta_t*10^n)~=delta_t*10^n)
    n = n+1;
end 
E = 1*10^-n;
ta = v_max/a_max;

if rem(ta,delta_t)~=0
    ta_new = round(ta,n)+E;
else 
    ta_new = round(ta,n);
end 

tf = (qf1-q01)/v_max + ta_new 

if rem(tf,delta_t)~=0
    tf_new = round(tf,n)+E;
else 
    tf_new = round(tf,n);
end 

v_new = ((qf1-q01)/(tf_new-ta_new))

a_new = v_new/ta_new 

t1 = 0:delta_t:tf_new;
%t0 -->ta:
a10 = q01;
a11 = v0;
a12 = 0.5*a_new;

%ta-->tf-ta:

a20 = q01 + 0.5*a_new*ta_new^2 - v_new*ta_new;
a21 = v_new;

%tf-ta -->tf:
a30 = qf1 - 0.5*a_new*tf_new^2;
a31 = a_new*tf_new;
a32 = -0.5*a_new;

q_new  = (a10+a11.*t1+a12.*t1.^2).*(t1<=ta_new) + (a20 + a21.*t1).*(t1>ta_new).*(t1<=(tf_new-ta_new)) + (a30 + a31.*t1+a32.*t1.^2).*(t1>(tf_new-ta_new)).*(t1<=tf_new);
v_new  = (a11 +2*a12.*t1).*(t1<=ta_new)+(a21).*(t1>ta_new).*(t1<=(tf_new-ta_new))+(a31 +2*a32.*t1).*(t1>(tf_new-ta_new)).*(t1<=tf_new);
a_new  = (2*a12).*(t1<=ta_new)+(0).*(t1>ta_new).*(t1<=(tf_new-ta_new))+(2*a32).*(t1>(tf_new-ta_new)).*(t1<=tf_new);

figure(4) 
plot(t,q,'k','linewidth',3)
hold on 
plot(t1,q_new,'linewidth',1)
grid on 
axis([0 tf_new q01 qf1])

figure(5)
plot(t,v,'k','linewidth',3)
grid on
hold on 
plot(t1,v_new,'linewidth',1)
grid on 
axis([0 tf_new 0 v_max])

figure(6)
plot(t,a,'k','linewidth',3)
hold on 
plot(t1,a_new,'linewidth',1)
grid on 
axis([0 tf_new -a_max a_max])
