function [zz,xx,yy] = feval(f,x,y,varargin)
% [zz,xx,yy] = feval(f,x,y,varargin)

if nargin > 3 || (length(x)==1 || length(y) == 1)
    mesh = true;
else
    mesh = false;
end

if ~mesh && any(size(x)~=size(y))
    error('fourier2:feval:input','size of x and y must agree -- see the mesh input option')
end

% interpolation points
XY = f.map.for(-pi+2*pi*(0:f.nx-1).'/f.nx, -pi+2*pi*(0:f.ny-1).'/f.ny);
xp = XY{1}; yp = XY{2};

if mesh
    if min(size(x)) >1 || min(size(y)) > 1
       error('fourier2:feval:input','both x and y must be vectors for meshgrid evaluations')
    end
    
    [xx,yy] = meshgrid(x(:),y(:));
    zz = nan(size(xx));
    
    if length(x) > length(y)
        zx = nan(f.nx,length(x));
        for k = 1:length(yp)
            zx(k,:) = bcinterp(xp,f.vals(k,:),x(:).');
        end
        for k = 1:length(y)
            zz(:,k) = bcinterp(yp,zx(:,k),y(:));
        end
    else
        zy = nan(f.ny,length(y));
        for k = 1:length(xp)
            zy(k,:) = bcinterp(yp,f.vals(:,k),y(:).');
        end
        for k = 1:length(x)
            zz(k,:) = bcinterp(xp,zy(:,k),x(:).');
        end
    end
else
    zz = nan(size(x));
    if f.nx < f.ny
        zy = nan(size(xp));
        for j = 1:numel(x)
            for k = 1:length(xp)
                zy(k) = bcinterp(yp,f.vals(:,k),y(j));
            end
            zz(j) = bcinterp(xp,zy,x(j));
        end
    else
        zx = nan(size(yp));
        for j = 1:numel(y)
            for k = 1:length(yp)
                zx(k) = bcinterp(xp,f.vals(k,:),x(j));
            end
            zz(j) = bcinterp(yp,zx,y(j));
        end
    end
end
        