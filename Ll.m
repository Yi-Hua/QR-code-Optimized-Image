function y = Ll(x,Im,QR,Mda)
% (Lout - L) in [Eq.18]
% Ll = (Lo - L)
% x =[a,b,ac,bc,pc]
% Aim (RGB) => (HSL) => L
HSL = rgb2hsl(Im);     Li = HSL(:,:,3);
% Aim (RGB) => (HSL) => (HSL*) => (R*G*B*) => f(L*) => L*==================
% L* = argmin |f(L)-lt|
%         L
[m,n] = size(QR);
lt = Yout(x,Im,QR,Mda);
Lo = zeros(m,n);
for k = 1 : m*n 
% (methd 1) ---------------------------------------------------------------
% fun = @(Ly) argfun_L(Ly,Im,lt,k) ;
% Lo(k) = fmincon(fun,0.2,[],[],[],[],0,1);
% (methd 2) ---------------------------------------------------------------
 Lo(k) = fL(Im,lt,k); % Lo
end
%imshow(Lo)
y = (Lo - Li);        % (Lout - L)
end