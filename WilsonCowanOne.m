function [dxdt] = WilsonCowanOne( t,x,p )

E=x(1,:);
I=x(2,:);

a = p.a;
b = p.b;
c = p.c;
d = p.d;
P = p.P;
Q = p.Q;

dEdt = -E + Sigm(a*E - b*I + P);
dIdt = -I + Sigm(c*E - b*I + Q);

dxdt = [dEdt;dIdt];

end

function S=Sigm(x)
S=1./(1+exp(-(x-4)));
end
