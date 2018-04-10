function J = J2(x,Im,QR,Mda) 
% (1/2)*(1-ssim(Yout,Y)) in [Eq.18]
%--------------------------------------------------------------------------
% J(a,b,ac,bc,pc) = (wl/N)*||h*(Lout - L)||F + (wh)*( 1-MSSIM(Yout,Y) ).
%                 = G(Y,Yout) + (wh)*( 1-MSSIM(Yout,Y) )....(18)
% wl = 1, wh = 1/2
%--------------------------------------------------------------------------
% Yout, Y
Y1 = rgb2gray(Im);          % Y   
Y2 = Yout(x,Im,QR,Mda);  % Yout  lt
% J------------------------------------------------------------------------
J = (1/2)*(1-ssim(Y1,Y2));

% J = (1/2)*(1-ssim(rgb2gray(Im),Yout(x,Im,QR,Hi,Mda)));

end