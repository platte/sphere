function varargout = simplify(f,dim,tol)

% tolerance provided?
if nargin < 3
    tol = eps;
end

if nargin < 2 || isempty(dim) 
    [f,ish1] = simplify(f,1,tol);
    [f,ish2] = simplify(f,2,tol);
    if nargout < 2
        varargout = f;
    elseif nargout < 3
        varargout = {f, ish1&ish2};
    elseif nargout < 4
        varargout = {f, ish1, ish2};
    else
        error('fourier2:simplify:nargout','at most 3 output arguments available.')
    end
    return
end

% Simplify in the x or y-direction
if dim == 2
    vals = f.vals.'; nx = f.ny; ny = f.nx;
else
    vals = f.vals; nx = f.nx; ny = f.ny;
end

yhat = fftshift(fft2(vals))/(nx*ny);

tail = yhat(:,[1:4, end-4:end]);
ish = norm(tail(:),inf)/f.scl;

if nargout < 2
    varargout = f;
elseif nargout < 3
    varargout = {f, ish};
else
    error('fourier2:simplify:nargout','number of output arguments must be less than 2')
end


end

