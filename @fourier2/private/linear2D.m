function map = linear2D(corners)
% MAP = LINEAR2D(CORNERS) creates a map structure for fourier2
% it returns a structure that defines a linear map.  
%
% MAP.FOR is a function that maps [-pi,pi]^2 to 
% [corners(1) corners(2)] x [corners(3) corners(4)].
% MAP.INV is the inverse map. 
% MAP.ID is a string that identifies the map. 


% Extract out input. 
a = corners(1); b = corners(2); c=corners(3); d=corners(4);

% linear2D map:
map = struct('for', @(s,t) [b*(s+pi)/(2*pi)+a*(pi-s)/(2*pi),d*(t+pi)/(2*pi)+c*(pi-t)/(2*pi)],...
             'inv', @(x,y) pi*[(x-a)/(b-a)-(b-x)/(b-a), (y-c)/(d-c)-(d-y)/(d-c)],...
             'derx',@(y) (b-a)/(2*pi) + 0*y,'dery',@(y) (d-c)/(2*pi) + 0*y,'name','linear','par',[a b c d]) ;

end