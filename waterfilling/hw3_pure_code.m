clc;
clear;
close all;
K = 3;
P = 0.4;
w = [1, 2, 2];
A = [1, 1, 1];
N = [0.1, 0.1, 0.5];
gamma = A.^2./N;
gammaInv = 1./(A.^2./N);
roots = gammaInv./w;
[roots,idx] = sort(roots);
roots = [roots, inf];
for i=1:K
    r1 = roots(i);
    r2 = roots(i+1);
    lambda = (sum(gammaInv(idx(1:i)))+P)/sum(w(idx(1:i)));
    if r1<=lambda && lambda<=r2
        break;
    end
end
opt_p = max(0,w*lambda-gammaInv);
opt_R = log2(1+gamma.*opt_p);
Rwf_sumrate = sum(w.*opt_R);
unif_p = P/K*ones(1,K);
unif_R = log2(1+gamma.*unif_p);
unif_Rsumrate = sum(w.*unif_R);