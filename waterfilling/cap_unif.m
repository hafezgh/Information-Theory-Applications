A     = 1;
K     = 10;
N     = 1000;
Sdb   = -10:10;
S     = 10.^(Sdb/10);
Pv    = A^2/3*S;
DC    = 0.5*log2(pi*exp(1)/6); % from the course
x     = K*A/N*(-N+1:2:N-1).'; % column form
y     = (K+1)*A/N*(-N:2:N);
Fz    = @(z)(z>-A).*(z<A).*(z+A)/(2*A)+(z>=A);
Py_x  = Fz(y(2:N+1)-x)-Fz(y(1:N)-x);
Cv    = 0*Sdb;
for i=1:numel(Sdb)
  Px    = Pv(i);
  px    = exp(-x.^2/(2*Px));
  px    = px/sum(px);
  Cv(i) = WBA(Py_x,x,x.^2,Px,px,Sdb(i));
  disp([i,Sdb(i),Cv(i)])
end
plot(Sdb,[0.5*log2(1+S);Cv;0.5*log2(1+S)+DC],'LineWidth',2)