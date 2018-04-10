function [Y1,Y2,Y3,Y4,Y5,Y6] = xab(QR,x)
% x(:,2) = xb;
% x(:,3) = xac;
% x(:,4) = xbc;
% x(:,5) = xpc;
% x(:,6) = s;

[mq,nq] = size(QR);

xa = x(:,1);
Y1 = zeros(10); Y2 = Y1; Y3 = Y1; Y4 = Y1; Y5 = Y1; Y6 = Y1;
for i = 1 : 100
Y1(i) = xa(i);
end

xb = x(:,2);
for i = 1 : 100
Y2(i) = xb(i);
end

xac = x(:,3);
for i = 1 : mq*nq
Y3(i) = xac(i);
end

xbc = x(:,4);
for i = 1 : mq*nq
Y4(i) = xbc(i);
end

xpc = x(:,5);
for i = 1 : mq*nq
Y5(i) = xpc(i);
end

xs = x(:,6);
for i = 1 : mq*nq
Y6(i) = xs(i);
end
end




