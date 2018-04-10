function [Y] = Pd(x,Im,QR,Mda,sigmaEta,Nn)
%[Eq.13]
% P_Derr(i,j)=normcdf(ac,mu_t,sigma_t)*(1-p1)+normcdf(bc,mu_t,sigma_t)*p1 + p1
% t = mu + b + Eta
% x = [ £\  £]  £\c  £]c  Pc  ]

X = rgb2gray(Im);
% x
a = x(1); b = x(2); ac = x(3); bc = x(4); pc = x(5);

N = Nn^2;  O = zeros(Nn); %I = ones(Nn);

p1 = sum(QR(:))/N;

[m,n] = size(QR);
Hi = Halftone(pc);
Hi = Hi(m,n);
% = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
Acn = O; Bcn = O; An = O; Bn = O;
Bn((Mda==0)&(QR==1)&(Hi==1))=1; % Bn : number of beta
An((Mda==0)&(QR==0)&(Hi==1))=1; % An : number of alpha
Bcn((Mda==1)&(QR==1))=1; % Bcn : number of bc 
Acn((Mda==1)&(QR==0))=1; % Acn : number of ac 

nac = sum(Acn(:)); nbc = sum(Bcn(:)); na = sum(An(:)); nb = sum(Bn(:));
mu =(a*na+b*nb+ac*nac+bc*nbc)/N; % mu of modified pixels in the window
%--------------------------------------------------------------------------
% U = I - (An+Bn+Acn+Bcn);  % U : unmodified pixels in the window
% Yij = X;   Yij(U==0) = 0;  % Yij unmodified pixels in the window
% mu_b = (sum(Yij(:))/N)*(1-pc); % mu of unmodified pixels

mu_b = (sum(X(:))/N)*(1-pc); % mu of unmodified pixels
%--------------------------------------------------------------------------
mu_t = mu + mu_b;
% = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
varb = (var(X(:))/N)*(1-pc);
sigma_t = sqrt(sigmaEta^2 + varb);
% = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
Y = normcdf(ac,mu_t,sigma_t)*(1-p1)-normcdf(bc,mu_t,sigma_t)*p1 + p1;

end
