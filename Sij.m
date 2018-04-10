function [ys,seq] = Sij(x,Im,QR,Mda,Mp,Pmax,sigmaEta,Wa,da,Nn)
% In [Eq.21] Perr - Pmax + s = 0 

PB = Pb(x,Im,QR,sigmaEta,Nn);           % [Eq.10]   
PD = Pd(x,Im,QR,Mda,sigmaEta,Nn);    % [Eq.13]

ps = Ps(Wa,da); % ps : probability of sampling error as a Gaussian with sigma = Wa/4;

Perr = PB*ps + PD*(1-ps);      % [Eq.14] 

Pmaxi = (1-mean(Mp(:)))*Pmax;  % [Eq.20]

s = x(6);

ys = [];
seq = Perr - Pmaxi + s ;

end