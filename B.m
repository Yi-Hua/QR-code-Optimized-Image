function [Yout] = B(l,Y,Wa)
[m,n,~] = size(Y);
HSL = rgb2hsl(Y);
H = HSL;
Lo = ones(m,n)*l;
k = 0;                             % L = l; 
%--------------------------------------------------------------------------
W = zeros(9*Wa,9*Wa);                          %  ー ー ー ー ー ー ー ー ー
W(Wa+1:8*Wa,Wa+1:8*Wa) = ones(Wa*7,Wa*7);      %  ー ― ― ― ― ― ― ― ー
W(2*Wa+1:7*Wa,2*Wa+1:7*Wa) = zeros(Wa*5,Wa*5); %  ー ― ー ー ー ー ー ― ー 
W(3*Wa+1:6*Wa,3*Wa+1:6*Wa) = ones(Wa*3,Wa*3);  %  ー ― ー ― ― ― ー ― ー 
                                          %   W = ー ― ー ― ― ― ー ― ー  
                                               %  ー ― ー ― ― ― ー ― ー
                                               %  ー ― ー ー ー ー ー ― ー
                                               %  ー ― ― ― ― ― ― ― ー
                                               %  ー ー ー ー ー ー ー ー ー
%--------------------------------------------------------------------------
w = ones(5*Wa,5*Wa);                           %        ― ― ― ― ― 
w(Wa+1:4*Wa,Wa+1:4*Wa) = zeros(Wa*3,Wa*3);     %        ― ー ー ー ―  
w(2*Wa+1:3*Wa,2*Wa+1:3*Wa) = ones(Wa,Wa);      %    w = ― ー ― ー ―    
                                               %        ― ー ー ー ―
                                               %        ― ― ― ― ―
%--------------------------------------------------------------------------
L1 = Lo(     1    :  9*Wa  ,     1    :  9*Wa  ) ;   L1(W == 1) = k;
L2 = Lo(     1    :  9*Wa  , n-9*Wa+1 :   n    ) ;   L2(W == 1) = k;
L3 = Lo( m-9*Wa+1 :   m    ,     1    :  9*Wa  ) ;   L3(W == 1) = k;
L4 = Lo( m-9*Wa+1 : m-4*Wa , n-9*Wa+1 : n-4*Wa ) ;   L4(w == 1) = k;
%--------------------------------------------------------------------------
Lout = HSL(:,:,3);
Lout(     1    :  9*Wa  ,     1    :  9*Wa  ) = L1 ;
Lout(     1    :  9*Wa  , n-9*Wa+1 :   n    ) = L2 ;
Lout( m-9*Wa+1 :   m    ,     1    :  9*Wa  ) = L3 ;
Lout( m-9*Wa+1 : m-4*Wa , n-9*Wa+1 : n-4*Wa ) = L4 ;
H(:,:,3) = Lout;

Yout = hsl2rgb(H);
end