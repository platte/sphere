function fhat = fft2(f)
% FFT2 fast fourier transform of a fourier2.
% FFT2(F) returns the Fourier coefficients of F properly rescaled and
% shifted.


nx = f.nx; ny = f.ny;

% The odd case (x starting at 0)
fhat = fftshift(fft2(f.vals))/(nx*ny);

%% nx even 
%if mod(nx,2) == 0 
    fhat(:,end+1) = fhat(:,1);
%end

%% ny even 
%if mod(ny,2) == 0 
    fhat(end+1,:) = fhat(1,:);
%end