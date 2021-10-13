function [C,px] = WBA(Py_x,x,w,Ptot,px,SNRdb)
C = 0;
for k=1:1000
  Pxy   = px.*Py_x;
  py    = sum(Pxy);
  Px_y  = Pxy./(py+eps);
  Clast = C;
  C     = Pxy;
  A     = Px_y./px;
  C     = sum(C(C>0).*log2(A(C>0)));
  plot(x,px/(x(2)-x(1)))
  title(sprintf('SNR=%.1f dB',SNRdb))
  pause(.001)
  if abs(C-Clast)<1e-6,break;end
  T     = Px_y.^Py_x;
  t     = prod(T,2);
  f     = @(u)sum(w.*exp(-u*w).*t)/sum(exp(-u*w).*t)-Ptot;
  mu    = max(0,fzero(f,1));
  px    = exp(-mu*w).*t/sum(exp(-mu*w).*t);
end