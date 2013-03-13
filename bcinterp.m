function ff = bcinterp(x,f,xx,w)
% computes the values ff taken by a trigonometric rational interpolant with
% barycentric weights w, interpolation points x, and function values f at the points xx
% using formula (3.29). Note that x must be arranged in increasing order.
% The nummber of data points may be even or odd.
n = length(x);
if nargin<4
    w = (-1).^(0:n-1)';
end
sizexx = size(xx); xx = xx(:);
nn = length(xx);
[sorted,indices] = sort([x(2:n);xx(1:nn)]);
sorted(indices) = cumsum(indices<=n-1)+1;
index = sorted(n:nn+n-1);
maska = (x(index)==xx);
maskb = (maska==0);
xxx = xx(maskb);
numer = zeros(length(xxx),1);
denom = zeros(length(xxx),1);

if mod(n,2), F = @(x) sin(x);       % odd number of points
else         F = @(x) tan(x); end   % even number of points

for i=1:n
    temp = w(i)./F((xxx-x(i))/2);
    numer = numer + temp*f(i);
    denom = denom + temp;
end

ff = zeros(nn,1);
ff(maskb) = numer./denom;
ff(maska) = f(index(maska));
ff = reshape(ff,sizexx);

