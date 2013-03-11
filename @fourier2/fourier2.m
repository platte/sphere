%FOURIER2 Class definition for fourier2 objects
%
% FOURIER2(OP,ENDS,N,M) constructs a fourier2 object on the domain given by ENDS.
%
% FOURIER2(...,N,M) constructs a fourer2 object on the domain given by ENDS.
%
% This class is mainly for developers and is not intended to be accessed
% directly by a user. 
%

classdef fourier2
    properties  ( GetAccess = 'public' , SetAccess = 'public' )
        nx          % number of modes in x direction
        ny          % number of modes in y derection
        F           % function values on the grid
        scl = 0     % Magnitude of fourier2.
        map = struct('for',[],'inv',[],'name',[]);         % Linear map to scale to unit square. 
    end
    properties  ( GetAccess = 'public' , SetAccess = 'public' )
        
    end
    methods
        function g = fourier2 ( varargin )
            if( nargin == 0 )
            else
                g = ctor( g, varargin{:} );  % pass to constructor. 
            end
        end
    end
end