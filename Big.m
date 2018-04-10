function Y = Big(X,Wa)
%  m*n  Image ��v���V�~�򰵹��
[m,n,s] = size(X);
Y = zeros(m+4*Wa,n+4*Wa,s);
%  __ __ __ __ __ __ __ __ __ __ __
% |2Wa^2|       2Wa*n        |     |   (1:2*Wa) (2*Wa+1:2*Wa+n) (2*Wa+n+1:4*Wa+n) 
% |__ __|__ __ __ __ __ __ __|__ __|      A11          B1           A12    (1:2*Wa)
% |     |                    |     | 
% |     |                    |     |  
% |     |                    |     |  
% |2Wa*m|        m*n         |     |      B2           Im            B3    (2*Wa+1:2*Wa+m)
% |     |                    |     | 
% |     |                    |     | 
% |__ __|__ __ __ __ __ __ __|__ __|     
% |     |                    |     |     A21          B4            A22    (2*Wa+m+1:4*Wa+m)
% |__ __|__ __ __ __ __ __ __|__ __|
a = 2*Wa;
Y( a+1 : a+m , a+1 : a+n , 1:s ) = X;
%--------------------------------------------------------------------------
A11 = X( 2  : 1+a ,  2  : 1+a , 1:s);
Y( 1:a, 1:a, 1:s) = rot90(A11,2);
A12 = X( 2  : 1+a , n-a : n-1 , 1:s);
Y( 1:a, a+n+1:n+2*a,1:s) = rot90(A12,2);
A21 = X(m-a : m-1 ,  2  : 1+a , 1:s);
Y(m+a+1:m+2*a, 1:2*Wa,1:s) = rot90(A21,2);
A22 = X(m-a : m-1 , n-a : n-1 , 1:s);
Y(m+a+1:m+2*a, n+a+1:n+2*a,1:s) = rot90(A22,2);
%--------------------------------------------------------------------------
B1 = X(  2  : a+1 ,  1  :  n  , 1:s);
Y(  1  :  a  , a+1 : a+n , 1:s) = flipud(B1);
B2 = X(  1  :  m  ,  2  : a+1 , 1:s);
Y( a+1 : a+m ,  1  :  a  , 1:s) = fliplr(B2);
B3 = X(  1  :  m  , n-a : n-1 , 1:s);
Y( a+1 : a+m ,a+n+1:2*a+n, 1:s) = fliplr(B3);
B4 = X( m-a : m-1 ,  1  :  n  , 1:s);
Y(a+m+1:2*a+m, a+1 : a+n , 1:s) = flipud(B4);
end
%    �� �� �� �� �� �� �� �� �� �� 
%    �� �� �� �� �� �� �� �� �� �� 
%    �� �� �� �� �� �� �� �� �� ��    where �� is a block Wa*Wa
%    �� �� �� �� �� �� �� �� �� ��
%    �� �� �� �� �� �� �� �� �� ��
%  => 
%                                         __ __ __ __ __
%? �� �� �� �� ��                         |33 23 31 32 23|34 35 
%? �� �� �� �� ��                         |32 22 21 22 23|24 25 
%? �� �� �� �� �� �� �� �� �� �� �� ��     |13 12 11 12 13|14 15 16 17 ...
%? �� �� �� �� �� �� �� �� �� �� �� ��     |23 22 21 22 23|24 25 26 27 ...
%? �� �� �� �� �� �� �� �� �� �� �� ��     |33 32 31 32 33|34 35 
%        �� �� �� �� �� �� �� �� �� ��            41 42 43 44 45 
%        �� �� �� �� �� �� �� �� �� ��            51 52 53 54 55
%