function [Y] = Yout(x,Im,QR,Mda) 
% [Eq.3]
% Luminance Modification  4 level : a,b,ac,bc  ¡P ¡P ¡P ¡P ¡P ¡P (3)
%  x = [  £\  £]  £\c £]c  Pc ]
a = x(1);  b = x(2);  ac = x(3);  bc = x(4);  pc = x(5); % s = x(6);
%            £]   ,if M = 0, q = 1, Ipc = 1.
%            £\   ,if M = 0, q = 0, Ipc = 0.
%  Yout_ij = £]c  ,if M = 1, q = 1.
%            £\c  ,if M = 1, q = 0.
%            Yij  ,otherwise.
[m,n] = size(QR);
Hi = Halftone(pc);
Hi = Hi(m,n);
Y = rgb2gray(Im);
Y((Mda == 0) & (QR == 1) & (Hi == 1)) = b;     % QR   0 or 1
Y((Mda == 0) & (QR == 0) & (Hi == 1)) = a;     % QR   1 or 0
Y((Mda == 1) & (QR == 1)) = bc;
Y((Mda == 1) & (QR == 0)) = ac;
end
        
        
%       _                  _            _                _ 
%      |                    |          |                  | 
% Im = |  X (picture) m*n*3 |     Q =  |  QR  code  m*n   | 
%      |_                  _|          |_                _|    
%       _                  _            _                 _ 
%      |                    |          |  ¡¼ ¡¼ ¡¼         |  
% Hi = |    HalftoneMask    |     Md = |  ¡¼ ¡½ ¡¼ (Wa*Wa) |
%      |_                  _|          |_ ¡¼ ¡¼ ¡¼        _|  


