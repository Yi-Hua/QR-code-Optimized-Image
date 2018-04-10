function rgb = hsl2rgb(hsl_in)
% RGB = hsl2rgb(HSL)
hsl = reshape(hsl_in,[], 3); % _ 1  2  3 _                              
%     reshape(hsl_in,[], 3) = |  o  o  o  |  X  = (m,n,3)                         
H = hsl(:,1); %               |  o  o  o  |, X1 = X(:,:,1), column1 = X1(:)
S = hsl(:,2); %               |  :  :  :  |  X2 = X(:,:,2), column2 = X2(:)
L = hsl(:,3); %               |_ o  o  o _|  X3 = X(:,:,3), column3 = X3(:) 
%----------------------------------------------------------------------#1.1
% q = / L กั (1 + S),    if L < (1/2)                                     
%     \ L + S - (L กั S),  if L ? (1/2)
lowLidx = L < (1/2);
q = (L .* (1+S) ).*lowLidx + (L+S-(L.*S)).*(~lowLidx); 
%p = 2 กั L - q.--------------------------------------------------------#1.2  
p = 2*L - q;                                               
% hk = H / 360 , h ยเฆจ [0,1) ถก --------------------------------------#1.3
hk = H; % this is already divided by 360
%----------------------------------------------------------------------#1.4
t=zeros([length(H), 3]); % 1=R, 2=B, 3=G
t(:,1) = hk + (1/3);                  % tR = hk + (1/3)
t(:,2) = hk;                          % tG = hk
t(:,3) = hk - (1/3);                  % tB = hk - (1/3)
% ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
% tC = [ tR ; tG ; tB ] 
underidx = t < 0;   % if tC < 0  =>  tC = tC + 1.0 
overidx = t > 1;    % if tC > 1  =>  tC = tC - 1.0   
t = t + underidx - overidx;
%-----------------------------------------------------------------------# 2    
range1 =  t < (1/6);               
range2 = (t >= (1/6) & t < (1/2)); 
range3 = (t >= (1/2) & t < (2/3)); 
range4 =  t >= (2/3);             
% replicate matricies (one per color) to make the final expression simpler
P = repmat(p, [1,3]);   Q = repmat(q, [1,3]);
rgb_c = (P + ((Q-P).*6.*t)).*range1 + ...        %  p + ((q-p) กั 6 tC          , if tC < (1/6)
        Q.*range2 + ...   %               Color_C = q                          , if (1/6) ? tC < (1/2)
        (P + ((Q-P).*6.*(2/3 - t))).*range3+ ... %  p + ((q-p) กั 6 ((2/3)-tC)) , if (1/2) ? tC < (2/3)
        P.*range4;                               %  p                          , otherwise 
%--------------------------------------------------------------------------
rgb = reshape(rgb_c, size(hsl_in));    % rgb_c (:,:) =>  (:,:,3)











% rgb_c = round(rgb_c.*10000)./10000; 






% Converts Hue-Saturation-Luminance Color value to Red-Green-Blue Color value
%
% Usage
%       RGB = hsl2rgb(HSL)
%
%   converts HSL, a M [x N] x 3 color matrix with values between 0 and 1
%   into RGB, a M [x N] X 3 color matrix with values between 0 and 1
%
% See also rgb2hsl, rgb2hsv, hsv2rgb

% (C) Vladimir Bychkovsky, June 2008
% written using: 
% - an implementation by Suresh E Joel, April 26,2003
% - Wikipedia: http://en.wikipedia.org/wiki/HSL_and_HSV



