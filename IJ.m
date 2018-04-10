function Y = IJ(m,n)
Y = zeros(m,n);
for i = 1:m
    for j = 1:n
        Y(i,j) = 10*i+j;
    end
end

