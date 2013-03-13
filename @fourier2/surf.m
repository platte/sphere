function H = surf(f,varargin)

fhat = fft2(f.vals);
if f.nx < 2^8
    %Pad in x-direction
    npad = 2^8 - f.nx;
    fhat = [fhat(:,1:f.nx/2) zeros(f.ny,npad) fhat(:,f.nx/2+1:end)];
else
    % Trim in the x-direction
    trim = f.nx - 2^8;
    fhat = [fhat(:,1:f.nx/2-trim/2-1) fhat(:,f.nx/2+trim/2:end)];
end
if f.ny < 2^8
    %Pad in x-direction
    npad = 2^8 - f.ny;
    fhat = [fhat(1:f.ny/2,:); zeros(npad,2^8); fhat(f.ny/2+1:end,:)];
else
    % Trim in the x-direction
    trim = f.ny - 2^8;
    fhat = [fhat(1:f.ny/2-trim/2-1,:); fhat(f.ny/2+trim/2:end,:)];
end

fvals = ifft2(fhat)*(2^16/(f.nx*f.ny));
fvals(:,end+1) = fvals(:,1);
fvals(end+1,:) = fvals(1,:);
[xx,yy] = fourierpts2(2^8,2^8,f.map.par,'close');

% Generate surface plot
if nargout == 0
    surf(xx,yy,real(fvals),varargin{:})
elseif nargout == 1
    H = surf(xx,yy,real(fvals),varargin{:});
else
    error('fourier2:surf:nargout','At most one output argument allowed')
end

end

    
