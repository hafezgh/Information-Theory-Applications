function HR = Hrate(fname,L,txt_filter,split_type,upcase)
%
% fname:      name of the file with the text
% L:          character grouping length (>=1)
% txt_filter: character filter (allowed characters)
% split_type: character grouping type ('separate' or 'overlapping')
% upcase:     upper case characters before filtering
%
if ~exist('fname','var'), fname='warandpeace.txt';end
if ~exist('L','var'), L=10;end
if ~exist('txt_filter','var'),txt_filter=['a':'z','A':'Z',' '];end
if ~exist('split_type','var'),split_type='separate';end
if ~exist('upcase','var'),upcase=false;end
t = fileread(fname);
if upcase,t=upper(t);end
c = t;
k = 0;
for i=1:numel(t)
  if contains(txt_filter,t(i))
    k=k+1;c(k)=t(i);
  end
end
k = floor(k/L)*L;
c = c(1:k); % filtered character array with length multiple of L
D = containers.Map; % Dictionary
switch split_type
  case 'separate'
    for i=1:L:k-L+1
      w = c(i:i+L-1);
      if isKey(D,w)
        D(w) = D(w)+1;
      else
        D(w) = 1;
      end
    end
  case 'overlapping'
    for i=1:k-L+1
      w = c(i:i+L-1);
      if isKey(D,w)
        D(w) = D(w)+1;
      else
        D(w) = 1;
      end
    end
end
N = D.values;
p = cell2mat(N); % word counter vector
p = p/sum(p); % word frequency vector
plot(p)
HR = H(p)/L;disp(HR)
[~,idx] = sort(p,'descend');
K = D.keys;
for i=1:10
  fprintf('%3d) "%s" %g\n',i,K{idx(i)},p(idx(i)))
end