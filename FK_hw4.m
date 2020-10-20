function T = FK_hw4(q,L)
T = Rz(q(1))*Tz(L(1))*Rx(q(2))*Tz(L(2))*Rx(q(3))*Tz(L(3));
end
