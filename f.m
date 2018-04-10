function y = f(L,Im,k)
% f(L) in [Eq.4]
I = zeros(1,1,3);     % One pixel.
I1 = Im(:,:,1);       % R
I2 = Im(:,:,2);       % G
I3 = Im(:,:,3);       % B
I(:,:,1) = I1(k);     % One pixel at k for R
I(:,:,2) = I2(k);     % One pixel at k for G
I(:,:,3) = I3(k);     % One pixel at k for B
% RGB => HSL => HSL* => R*G*B* --------------------------------------------
HSL = rgb2hsl(I);     % RGB => HSL       (1,1,3)
HSL(:,:,3) = L;       % HSL => HSL*   
Imo = hsl2rgb(HSL);   % HSL* => R*G*B*   (1,1,3)
%--------------------------------------------------------------------------
y = rgb2gray(Imo);    % Luminance  Yout                
end