function [xx,yy] = fourierpts2(nx,ny,varargin)
%CHEBPTS2 Chebyshev tensor points
%
% [XX YY] = CHEBPTS2(N) constructs an N by N grid of Chebyshev 
% tensor points on [-1 1]^2. 
%
% [XX YY] = CHEBPTS2(NX,NY) constructs an NX by NY grid of
% Chebyshev tensor points on [-1 1]^2.  
%
% [XX YY] = CHEBPTS2(NX,NY,D) constructs an NX by NY grid of 
% Chebyshev tensor points on the rectangle [a b] x [c d], where 
% D = [a b c d].
%
% See also CHEBPTS.


if ( nargin > 2 )  % third argument should be a domain. 
   D = varargin{1}; 
   D = D(:).';  % make a row vector.   
   if ( ~all( size(D) == [1 4] ) )
        error('CHEBFUN2:CHEBPTS2:DOMAIN','Unrecognised domain');
   end
else  % default to the domain in preferences. 
    xdom = [-pi pi];
    ydom = [-pi pi];
    D = [xdom ydom]; 
end

if nargin == 1 % make it a square chebyshev grid. 
    ny = nx; 
end

if nargin >2 && isa(varargin{end},'char') % include points at pi?
    x = D(1)+(D(2)-D(1))*(0:nx)/nx;
    y = D(3)+(D(4)-D(3))*(0:ny)/ny;
else
    x = D(1)+(D(2)-D(1))*(0:nx-1)/nx;
    y = D(3)+(D(4)-D(3))*(0:ny-1)/ny;
end

[xx, yy] = meshgrid(x,y);   % tensor product. 

end 