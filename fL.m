function Lk = fL(Im,lt,k)
% [Eq.5] : L* = argmin |f(L)-lt|
% (methd 2) 

w = 100;
Lg = zeros(1,w);
for g = 1:w
    Lg(g) = abs(f(g/w,Im,k) - lt(k));
end
[~,index] = min(Lg) ;
Lk = index/w;
end
