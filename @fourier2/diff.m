function f = diff(f,nderx,ndery)

% Default input arguments
if nargin < 2
    nderx = 1;
end
if nargin < 3
    ndery = 0;
end

yhat = fft2(f.vals); 
[nnx,nny] = meshgrid(1i*[0:f.nx/2 -f.nx/2+1:-1], 1i*[0:f.ny/2 -f.ny/2+1:-1]);
dyhat = (nnx).^nderx.*(nny).^ndery.*yhat;
if mod(nderx,2) ~=0
    dyhat(:,f.nx/2+1) = 0;
end
if mod(ndery,2) ~=0
    dyhat(f.ny/2+1) = 0;
end
dvals = ifft2(dyhat);

% Chain rule for scalled domains
dvals = ( (2*pi/diff(f.map.par(1:2)))^nderx * ...
          (2*pi/diff(f.map.par(3:4)))^ndery ) * dvals;

f.scl = max(f.scl,max(max(abs(dvals))));
if isreal(f.vals)
    f.vals = real(dvals);
elseif isreal(1i*f.vals)
    f.vals = 1i*imag(dvals);
else
    f.vals = dvals;
end



