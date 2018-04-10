function [Y] = Pb(x,Im,QR,sigmaEta,Nn)
% [Eq.10]
% Pberr = pc¡P£Uwk( p0¡PF(£\-tk) - p1¡PF(£]-tk) ) + (1-pc)¡P£Uwk(p0-p1)¡PF(Yij-tk) + p1
% F(x) = P(X < = x) is cdf('Normal', X , mu ,sigma)
% wk = C(n,k)p1^(k)p0^(n-k) , tk = [ (kb+(n-k)a)/(25*64) ]
%
% x = [ £\  £]  £\c  £]c  Pc  ]---------------------------------------------
  a = x(1);   b = x(2);   pc = x(5);
%-rgb2gray------------+--N = (Wa*black)^2-----+ Initial value -------------
  X = rgb2gray(Im);      N = Nn^2;              F1 = 0;    F2 = 0;
%-Luminance Modification Number : n ----+ P(q = 1)-------------------------
  n = floor(pc* N);                       p1 = sum(QR(:))/N;
for k = 0 : n 
    % wk = C(n,k)p1^(k)p0^(n-k)--------------------------------------------
    w =  binopdf(k,n,p1);   % binopdf(X,N,P) = f(x|n,p) = C(n,x)p^(x)(1-p)^(n-x)
    % tk = [ (kb+(n-k)a)/(25*64) ]-----------------------------------------
    t = floor((k*b + (n-k)*a)/N);  
    Yi = X - t*ones(Nn);   
    % £m = (£my^2+£mn^2)^(1/2)---------------------------------------------
    Sy = sqrt(var(Yi(:))*(1-pc)/N + sigmaEta^2);
%-------------------------------------------------------------------------- 
    % F(£\-tk)    muy = mean(Yi(:))
    Fa = normcdf(a-t,mean(Yi(:))*(1-pc),Sy);
    
    % F(£]-tk)
    Fb = normcdf(b-t,mean(Yi(:))*(1-pc),Sy);
    
    % F(Yij-tk)  mean or max ??
    FFy = normcdf(Yi,mean(Yi(:))*(1-pc),Sy);
    Fy  = mean(FFy(:));  % Or max ?
%--------------------------------------------------------------------------
    f1 = w*( (1-p1)*Fa - p1*Fb );  F1 = F1 + f1;
    f2 = w*(1 - 2*p1)*Fy;          F2 = F2 + f2;              
    
end

 Y = pc*F1 + (1-pc)*F2 + p1;
 clear n k p1 F1 F2
end
            
            
            
            
            
            
            