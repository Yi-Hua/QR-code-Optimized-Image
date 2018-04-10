function [A,B] = T(x)
xa = x(:,1);
xb = x(:,2);
A = ones(4);
B = ones(4);
for i = 1:16
    A(i) = xa(i);
    B(i) = xb(i);
end


end
    

