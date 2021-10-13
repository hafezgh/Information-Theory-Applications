function y = H(p)
    p = p(:);
    p = p(p>0);
    p = p/sum(p);
    y = sum(-p.*log2(p));