function [Y] = MP(X,Wa)
% Mp mask => To find canny edge  [Eq.20]
[m,n] = size(X);
Y = zeros(m,n);
% canny : edge => 1 , 
Yo = edge(X,'canny');
Yo = double(Yo);
%--------------------------------------------------------------------------
%       canny       Mp
% edge    1    =>   -2 
% other   0    =>    0
% QR ¦^   x    =>    1 

Y( Yo == 1 ) = -2;
Y(     1    :  9*Wa  ,     1    :  9*Wa  ) = 1;
Y(     1    :  9*Wa  , n-9*Wa+1 :   n    ) = 1;
Y( m-9*Wa+1 :   m    ,     1    :  9*Wa  ) = 1;
Y( m-9*Wa+1 : m-4*Wa , n-9*Wa+1 : n-4*Wa ) = 1;
end