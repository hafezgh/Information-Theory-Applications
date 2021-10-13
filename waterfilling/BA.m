Py_x = [...
  .8,.1,.1;
  .1,.7,.2;
  .0,.1,.9];
[M,N] = size(Py_x);
px    = ones(M,1)/M;
C     = 0;
for k=1:1000
  Pxy   = px.*Py_x; % joint prob matrix p(x,y) (M x N)
  py    = sum(Pxy); % row vector of p(y) (1 x N)
  Px_y  = Pxy./py;  % conditional prob matrix p(x|y) (M x N)
                    % corresponds to the q_k(x|y)
	Clast = C;        % for comparison
  % I use the formula
  % I(X;Y)=H(X)-H(X|Y)=sum_{x,y}p(x,y)*log2(p(x|y)/p(x))
  C     = Pxy;
  A     = Px_y./px;
  C     = sum(C(C>0).*log2(A(C>0)));
  fprintf('%4d) p(x) = ',k)
  fprintf('%8.4f',px)
  fprintf(' C = %24.20f\n',C)
  if C-Clast < 1e-20
    break;
  end
  T     = Px_y.^Py_x;
  t     = prod(T,2);
  px    = t/sum(t); % next input probability vector
end