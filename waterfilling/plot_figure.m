P     = [8 1 1;2 3 5;1 8 1;3 3 4]/10;
w     = 1:4;
Pt1   = 1;
[C,p] = BA(P);
Pt2   = w*p;
Ptv   = linspace(Pt1,Pt2);
Cv    = 0*Ptv;
for i=1:numel(Ptv)
  Cv(i) = WBA(P,w,Ptv(i));
end
plot([Pt1,3],[C,C],Ptv,Cv,'LineWidth',2)