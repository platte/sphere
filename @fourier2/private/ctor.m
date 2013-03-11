function g = ctor( g , op , ends , nx, ny )
% fourier2 constructor 


g.map = linear2D(ends);  
g.nx = nx;
g.ny = ny;
[x,y] = fourierpts2(nx,ny,ends)
g.F = op(x,y);
g.scl = max(max(abs(g.F)));



