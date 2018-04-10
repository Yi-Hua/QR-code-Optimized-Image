function Y = Beta(QR,x)
% x(:,2) = xb;
% x(:,3) = xac;
% x(:,4) = xbc;
% x(:,5) = xpc;
% x(:,6) = s;

[mq,nq] = size(QR);
xb = x(:,2);
Y = zeros(mq,nq);
for i = 1 : mq*nq
Y(i) = xb(i);
end

end