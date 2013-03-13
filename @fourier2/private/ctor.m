function g = ctor( g , op , ends , nx, ny )
% fourier2 constructor 

% nonadaptive case
g.map = linear2D(ends);  
if mod(nx,2)~=0
    error('fourier2:ctor:npoints','number of points in the x-direction must be even')
end
if mod(ny,2)~=0
    error('fourier2:ctor:npoints','number of points in the y-direction must be even')
end
g.nx = nx;
g.ny = ny;
[x,y] = fourierpts2(nx,ny,ends);
g.vals = op(x,y);
g.scl = max(max(abs(g.vals)));



