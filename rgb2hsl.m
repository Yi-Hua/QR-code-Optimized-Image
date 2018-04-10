function hsl = rgb2hsl(rgb_in)
% HSL = rgb2hsl(RGB)
rgb = reshape(rgb_in,[], 3); % _ 1  2  3 _                              
%     reshape(rgb_in,[], 3) = |  o  o  o  |  X  = (m,n,3)                         
%                             |  o  o  o  |, X1 = X(:,:,1), column1 = X1(:)
%                             |  :  :  :  |  X2 = X(:,:,2), column2 = X2(:)
%                             |_ o  o  o _|  X3 = X(:,:,3), column3 = X3(:)
% L = (max(r,g,b) + min(r,g,b))/2------------------------------------------
mx = max(rgb,[],2);    % max of the 3 colors  
mn = min(rgb,[],2);    % min of the 3 colors
L = (mx + mn)/2;       % L = (max(r,g,b) + min(r,g,b))/2
% S -----------------------------------------------------------------------
%     0                                    , if L = 0 or max = min
% S = (mx-mn)/(mx+mn) = (mx-mn)/2L         , if 0 < L ? 0.5
%     (mx-mn)/[2-(mx+mn)] = (mx-mn)/(2-2L) , if  L > 0.5
%- - - - - - - - S = 0, if L = 0 or max = min - - - - - - - - - - - - - - - 
S = zeros(size(L));  zeroidx = (mx == mn);   S(zeroidx) = 0;
% - - - - S = (mx - mn)/(mx + mn) = (mx - mn)/2L, if 0 < L ? 0.5 - - - - -
lowlidx = L <= 0.5;              calc = (mx-mn)./(mx+mn); 
idx = lowlidx & (~ zeroidx);     S(idx) = calc(idx);
% - - - - S =(mx-mn)/[2-(mx+mn)] = (mx-mn)/(2-2L), if  L > 0.5 - - - - - -
hilidx = L > 0.5;                calc = (mx-mn)./(2-(mx+mn));
idx = hilidx & (~ zeroidx);      S(idx) = calc(idx);
% H -----------------------------------------------------------------------
hsv = rgb2hsv(rgb_in); 
H = hsv(:,:,1);  H = H(:);
%--------------------------------------------------------------------------
hsl = [H, S, L];
hsl = reshape(hsl, size(rgb_in));






% hsl=round(hsl.*100000)./100000; 


%Converts Red-Green-Blue Color value to Hue-Saturation-Luminance Color value
%
%Usage
%       HSL = rgb2hsl(RGB)
%
%   converts RGB, a M [x N] x 3 color matrix with values between 0 and 1
%   into HSL, a M [x N] X 3 color matrix with values between 0 and 1
%
%See also hsl2rgb, rgb2hsv, hsv2rgb

% (C) Vladimir Bychkovsky, June 2008
% written using: 
% - an implementation by Suresh E Joel, April 26,2003
% - Wikipedia: http://en.wikipedia.org/wiki/HSL_and_HSV