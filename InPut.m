% Input 
%--Image----------+-parameter-------+-four levels-------+-Algorithm--------
  Im = Aim;        Wa = 8;           Pmax = 0.2;         kn = 4;       
  Q  = QR39;       da = 2;           sEta = 0.1;         ki = 1/2;
  bk = 5;          l = 0.95; 
%--------------------------------------------------------------------------  
% Im : Image, Aim (312x312x3 pixels) / Aim156 (156x156x3 pixels) AngryBirds
% Q  : QR code, QR39 (39x39 pixels)  
% Hi : HalftoneMask,  H1 / H2 /.../ H9 => HalftoneMask1 ~ HalftoneMask9
% Pmax : the global parameter in [Eq.20]
%--------------------------------------------------------------------------
% Wa, da  in [Fig. 3]              | [Eq. 2] sub window of 5x5 blocks
%    ________                      | Let bk = 5
%   |   __   |                     |
%   |  |__|da|                     |
%   |________|                     |
%       Wa                         |
%-------------------------------------------------------------------------- 
% In TIP paper IX. in the third paragraph : Sigma_Eta  0.1 < sEta < 0.2
% In [Fig.6], sEta = 0.1
%--------------------------------------------------------------------------
% Algorithm in [Eq. 21]
% argmin J(a,b,ac,bc,pc) + mu*log(s)....................(21)
% Let mu = (ki)^kn for ki = 1/2 and kn = 1:4
%--------------------------------------------------------------------------
% l 是 Finger Patterns 中白色部分的亮度
%--------------------------------------------------------------------------