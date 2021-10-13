P = 0.4;
K = 3;
w = [1,2,2];
A = [1,1,1];
N = [.1,.1,.5];
g = A.^2./N;
x = 1./w./g;
[x,idx] = sort(x);
x = [x,inf];
for i=1:K
  x1 = x(i);
  x2 = x(i+1); % segment (x1,x2)
  % equation to solve: sum_k max(0,lambda*w_k-1/gamma_k) = P
  % assume that the terms are positive for k<=i
  % then the equation becomes
  % sum_{k<=i} (lambda*w_k-1/gamma_k) = P
  % lambda*sum_{k<=i}w_k = sum_{k<=i}(1/gamma_k) + P
  % lambda = (sum_{k<=i}(1/gamma_k) + P)/(sum_{k<=i}w_k)
  % if this lambda is in (x1,x2) we have finished
  lambda = (sum(1./g(idx(1:i)))+P)/sum(w(idx(1:i)));
  fprintf('Segment considered: (%f,%f)',x1,x2)
  fprintf(' Candidate solution: %f\n',lambda)
  if x1<=lambda && lambda<=x2
    break; % we have found the water-filling solution
  end
end
p = max(0,w*lambda-1./g); % water-filling (optimum) power allocation vector
R = log2(1+g.*p); % corresponding rate vector
Rwf = sum(w.*R); % water-filling sum rate (optimum)
% with uniform power allocation we have the following:
p   = P/K*ones(1,K);
Rup = log2(1+g.*p); % rate vector with uniform power allocation
Rupsum = sum(w.*Rup); % corresponding sum rate
% with the power allocation vector of the lesson
p   = [.2 .1 .1];
R1  = log2(1+g.*p); % rate vector with "lesson" power allocation
R1sum = sum(w.*R1); % corresponding sum rate
%keyboard