function y = Ps(Wa,da)
% The probability of sampling error : ps
% As a Gaussian with sigma = Wa/4;
%           Wa       
%     ー    ー    ー 
%           da
%     ー    ―da  ー  Wa 
% 
%     ー    ー    ー 
%
% Ps = 1 - ′′f(x,y)dx dy  with (da/2),(-da/2)
%    = 1 - ′′f(x)f(y)dxdy
%    = 1 - (1-2F(-da/2))^2
%
x = -da/2;
mu = 0;
sigma = Wa/4;
y = 1 - (1-2*normcdf(x,mu,sigma))^2;
end



