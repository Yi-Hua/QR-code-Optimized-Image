% Eq(21)------------------------------------------------------------------- 
 clear variables
 Variable % run variable.m 
 InPut % run InPut.m
%--parameter-------------+------------------------+------------------------     
  Nn = Wa* bk;            [mq,nq] = size(Q);       I = rgb2gray(Im);                    
  N = (Nn)^2;             Yaim = Im;               Mp = MP(I,Wa);    % [Eq.20] Mp
%------------------------+------------------------+------------------------
  Q = ones(mq,nq) - Q; 
  % [Eq.3] QR value : it seem like qij = 1 is white, qij = 0 is black , but it's wrong.
  % So, we trun it : qij = 1 is black, qij = 0 is white.
  
  QR = Q2Q(Q,Wa);  % QR 39x39 => 312x312 
  Mda = ones(Wa*mq,Wa*nq)-Q2Qo(zeros(mq,nq),Wa,da); % [Eq.3] : Mij  
%--x = [a,b,ac,bc,pc,s]--+------------------------+------------------------
  xn = ones(mq*nq,6);         x1 = ones(1,6);         
  xo = x1*(0.5);          x0 = [0,0,0,0,0,-1]; % -1 < s < 1            
% HVS : h[m,n], D = 9 inches, R = 150 dpi, (0.525, 3.91) in [Eq.15]
  Hvs = HVS(Im,N);
%--Bigim Big-------------+------------------------+------------------------
  Ima  = Big(Im,Wa);      QRa  = Big(QR,Wa);       Mdaa = Big(Mda,Wa); 
  Mpa  = Big(Mp,Wa);      Hvsa = Big(Hvs,Wa); 
%---- window ij -----------------------------------------------------------

% < Part 2 >---------------------------------------------------------------
  for i = 1 : mq                                                    
     for j = 10 : nq-9 
        % Windows 
        Imi  =  Ima(Wa*(i-1) + 1 : Wa*(i-1) + Nn, Wa*(j-1) + 1 : Wa*(j-1) + Nn , 1:3);
        QRi  =  QRa(Wa*(i-1) + 1 : Wa*(i-1) + Nn, Wa*(j-1) + 1 : Wa*(j-1) + Nn);
        Mdai = Mdaa(Wa*(i-1) + 1 : Wa*(i-1) + Nn, Wa*(j-1) + 1 : Wa*(j-1) + Nn);
        Hvsi = Hvsa(Wa*(i-1) + 1 : Wa*(i-1) + Nn, Wa*(j-1) + 1 : Wa*(j-1) + Nn);
        Mpi  =  Mpa(Wa*(i-1) + 1 : Wa*(i-1) + Nn, Wa*(j-1) + 1 : Wa*(j-1) + Nn);
% (Eq 21)---argmin Ji(a,b,ac,bc,pc) + mu*log(s) subject to Perr - Pmax,i + s = 0----------------------------------------------------  
        for  k = 1:kn 
            fun1 = @(x) (1/N)*norm(Hvsi.* Ll(x,Imi,QRi,Mdai),'fro') + J2(x,Imi,QRi,Mdai) + ((ki)^k)*log(x(6)); % [Eq.18]
            fun2 = @(x) Sij(x,Imi,QRi,Mdai,Mpi,Pmax,sEta,Wa,da,Nn); % [Eq.21] subject to Perr - Pmax,i + s = 0
            xo = fmincon(fun1,xo,[],[],[],[],x0,x1,fun2);
        end
% (Eq 19)---argmin Ji(a,b,ac,bc,pc) + mulog(s) subject to Perr < Pmax,i ------------------------------------------------------------  
%         fun1 = @(x) (1/N)*norm(Hvsi.* Ll(x,Imi,QRi,Hii,Mdai),'fro') + J2(x,Imi,QRi,Hii,Mdai);
%         fun2 = @(x) Sij1(x,Imi,QRi,Hii,Mdai,Mpi,Pmax,sigmaEta,Wa,da,Nn);
%         xo = fmincon(fun1,xo,[],[],[],[],x0,x1,fun2);    
%-----------------------------------------------------------------------------------------------------------------------------------        
        xn((i-1)*nq + j,1:6) = xo;                  
        Y(Wa*(i-1)+1:Wa*(i-1)+Wa,Wa*(j-1)+1:Wa*(j-1)+Wa , 1:3) = Output(xo,Imi,QRi,Mdai,Wa); 
        Yaim(Wa*(i-1)+1:Wa*(i-1)+Wa,Wa*(j-1)+1:Wa*(j-1)+Wa , 1:3) = Y(Wa*(i-1)+1:Wa*(i-1)+Wa,Wa*(j-1)+1:Wa*(j-1)+Wa , 1:3);           
     end
  end
  
% < Part 1 >---------------------------------------------------------------
  for i =  10 : mq-9                                                   
     for j = 1 : 9 
        % Windows 
        Imi  =  Ima(Wa*(i-1) + 1 : Wa*(i-1) + Nn, Wa*(j-1) + 1 : Wa*(j-1) + Nn , 1:3);
        QRi  =  QRa(Wa*(i-1) + 1 : Wa*(i-1) + Nn, Wa*(j-1) + 1 : Wa*(j-1) + Nn);
        Mdai = Mdaa(Wa*(i-1) + 1 : Wa*(i-1) + Nn, Wa*(j-1) + 1 : Wa*(j-1) + Nn);
        Hvsi = Hvsa(Wa*(i-1) + 1 : Wa*(i-1) + Nn, Wa*(j-1) + 1 : Wa*(j-1) + Nn);
        Mpi  =  Mpa(Wa*(i-1) + 1 : Wa*(i-1) + Nn, Wa*(j-1) + 1 : Wa*(j-1) + Nn);
% (Eq 21)---argmin Ji(a,b,ac,bc,pc) + mu*log(s) subject to Perr - Pmax,i + s = 0----------------------------------------------------  
        for  k = 1:kn 
            fun1 = @(x) (1/N)*norm(Hvsi.* Ll(x,Imi,QRi,Mdai),'fro') + J2(x,Imi,QRi,Mdai) + ((ki)^k)*log(x(6)); % [Eq.18]
            fun2 = @(x) Sij(x,Imi,QRi,Mdai,Mpi,Pmax,sEta,Wa,da,Nn); % [Eq.21] subject to Perr - Pmax,i + s = 0
            xo = fmincon(fun1,xo,[],[],[],[],x0,x1,fun2);
        end  
        xn((i-1)*nq + j,1:6) = xo;                  
        Y(Wa*(i-1)+1:Wa*(i-1)+Wa,Wa*(j-1)+1:Wa*(j-1)+Wa , 1:3) = Output(xo,Imi,QRi,Mdai,Wa); 
        Yaim(Wa*(i-1)+1:Wa*(i-1)+Wa,Wa*(j-1)+1:Wa*(j-1)+Wa , 1:3) = Y(Wa*(i-1)+1:Wa*(i-1)+Wa,Wa*(j-1)+1:Wa*(j-1)+Wa , 1:3);              
     end
  end
  
% < Part 3 >---------------------------------------------------------------
for j = nq-8 : nq                                           
     for  i = 10 : mq-9 
        Imi  =  Ima(Wa*(i-1) + 1 : Wa*(i-1) + Nn, Wa*(j-1) + 1 : Wa*(j-1) + Nn , 1:3);
        QRi  =  QRa(Wa*(i-1) + 1 : Wa*(i-1) + Nn, Wa*(j-1) + 1 : Wa*(j-1) + Nn);
        Mdai = Mdaa(Wa*(i-1) + 1 : Wa*(i-1) + Nn, Wa*(j-1) + 1 : Wa*(j-1) + Nn);
        Hvsi = Hvsa(Wa*(i-1) + 1 : Wa*(i-1) + Nn, Wa*(j-1) + 1 : Wa*(j-1) + Nn);
        Mpi  =  Mpa(Wa*(i-1) + 1 : Wa*(i-1) + Nn, Wa*(j-1) + 1 : Wa*(j-1) + Nn);
% (Eq 21)---argmin Ji(a,b,ac,bc,pc) + mulog(s) subject to Perr < Pmax,i -----------------------------------------------------------  
        for  k = 1:kn 
            fun1 = @(x) (1/N)*norm(Hvsi.* Ll(x,Imi,QRi,Mdai),'fro') + J2(x,Imi,QRi,Mdai) + ((ki)^k)*log(x(6)); % [Eq.18]
            fun2 = @(x) Sij(x,Imi,QRi,Mdai,Mpi,Pmax,sEta,Wa,da,Nn); % [Eq.21] subject to Perr - Pmax,i + s = 0
            xo = fmincon(fun1,xo,[],[],[],[],x0,x1,fun2);
        end      
        xn((i-1)*nq + j,1:6) = xo;
        Y(Wa*(i-1)+1:Wa*(i-1)+Wa,Wa*(j-1)+1:Wa*(j-1)+Wa , 1:3) = Output(xo,Imi,QRi,Mdai,Wa); 
        Yaim(Wa*(i-1)+1:Wa*(i-1)+Wa,Wa*(j-1)+1:Wa*(j-1)+Wa , 1:3) = Y(Wa*(i-1)+1:Wa*(i-1)+Wa,Wa*(j-1)+1:Wa*(j-1)+Wa , 1:3); 
     end
     for  i = mq-3 : mq 
        Imi  =  Ima(Wa*(i-1) + 1 : Wa*(i-1) + Nn, Wa*(j-1) + 1 : Wa*(j-1) + Nn , 1:3);
        QRi  =  QRa(Wa*(i-1) + 1 : Wa*(i-1) + Nn, Wa*(j-1) + 1 : Wa*(j-1) + Nn);
        Mdai = Mdaa(Wa*(i-1) + 1 : Wa*(i-1) + Nn, Wa*(j-1) + 1 : Wa*(j-1) + Nn);
        Hvsi = Hvsa(Wa*(i-1) + 1 : Wa*(i-1) + Nn, Wa*(j-1) + 1 : Wa*(j-1) + Nn);
        Mpi  =  Mpa(Wa*(i-1) + 1 : Wa*(i-1) + Nn, Wa*(j-1) + 1 : Wa*(j-1) + Nn);
% (Eq 21)---argmin Ji(a,b,ac,bc,pc) + mulog(s) subject to Perr < Pmax,i -----------------------------------------------------------  
        for  k = 1:kn 
            fun1 = @(x) (1/N)*norm(Hvsi.* Ll(x,Imi,QRi,Mdai),'fro') + J2(x,Imi,QRi,Mdai) + ((ki)^k)*log(x(6)); % [Eq.18]
            fun2 = @(x) Sij(x,Imi,QRi,Mdai,Mpi,Pmax,sEta,Wa,da,Nn); % [Eq.21] subject to Perr - Pmax,i + s = 0
            xo = fmincon(fun1,xo,[],[],[],[],x0,x1,fun2);
        end        
        xn((i-1)*nq + j,1:6) = xo;
        Y(Wa*(i-1)+1:Wa*(i-1)+Wa,Wa*(j-1)+1:Wa*(j-1)+Wa , 1:3) = Output(xo,Imi,QRi,Mdai,Wa); 
        Yaim(Wa*(i-1)+1:Wa*(i-1)+Wa,Wa*(j-1)+1:Wa*(j-1)+Wa , 1:3) = Y(Wa*(i-1)+1:Wa*(i-1)+Wa,Wa*(j-1)+1:Wa*(j-1)+Wa , 1:3); 
     end
end
for j = nq-3 : nq                                           
     for  i = mq-8 : mq-4 
        Imi  =  Ima(Wa*(i-1) + 1 : Wa*(i-1) + Nn, Wa*(j-1) + 1 : Wa*(j-1) + Nn , 1:3);
        QRi  =  QRa(Wa*(i-1) + 1 : Wa*(i-1) + Nn, Wa*(j-1) + 1 : Wa*(j-1) + Nn);
        Mdai = Mdaa(Wa*(i-1) + 1 : Wa*(i-1) + Nn, Wa*(j-1) + 1 : Wa*(j-1) + Nn);
        Hvsi = Hvsa(Wa*(i-1) + 1 : Wa*(i-1) + Nn, Wa*(j-1) + 1 : Wa*(j-1) + Nn);
        Mpi  =  Mpa(Wa*(i-1) + 1 : Wa*(i-1) + Nn, Wa*(j-1) + 1 : Wa*(j-1) + Nn);
% (Eq 21)---argmin Ji(a,b,ac,bc,pc) + mulog(s) subject to Perr < Pmax,i -----------------------------------------------------------  
        for  k = 1:kn 
            fun1 = @(x) (1/N)*norm(Hvsi.* Ll(x,Imi,QRi,Mdai),'fro') + J2(x,Imi,QRi,Mdai) + ((ki)^k)*log(x(6)); % [Eq.18]
            fun2 = @(x) Sij(x,Imi,QRi,Mdai,Mpi,Pmax,sEta,Wa,da,Nn); % [Eq.21] subject to Perr - Pmax,i + s = 0
            xo = fmincon(fun1,xo,[],[],[],[],x0,x1,fun2);
        end        
        xn((i-1)*nq + j,1:6) = xo;
        Y(Wa*(i-1)+1:Wa*(i-1)+Wa,Wa*(j-1)+1:Wa*(j-1)+Wa , 1:3) = Output(xo,Imi,QRi,Mdai,Wa); 
        Yaim(Wa*(i-1)+1:Wa*(i-1)+Wa,Wa*(j-1)+1:Wa*(j-1)+Wa , 1:3) = Y(Wa*(i-1)+1:Wa*(i-1)+Wa,Wa*(j-1)+1:Wa*(j-1)+Wa , 1:3); 
     end
end
clear t1 t2 x0 x1 m n mq nq N Nn 

[Aa,Bb,Ac,Bc,Pc,s] = xab(QR,xn);

imshow(Yaim)
YaimQR = B(l,Yaim,Wa);      % ¥[¤WFinder patterns ©M Alignment patterns
imshow(YaimQR)

%---- window ij -----------------------------------------------------------
% Three Part : < Part1 > / < Part2 > / < Part3 >
%  __ __ __ __ __ 
% |__|        |__|          
% |  :        :  |      
% |1 :   2    :3 |    
% |__:        ¡½ |    
% |__|__ __ __:__|

% xn--((i-1)*t2+j)---------------------------------------------------------
%   ______________________________
%  | W(1,1) |    ....    | W(1,t2)|       x1 =  x(1,1)
%  |      __|_____       |        |       x2 =  x(1,2)
%  |_____|__|     |      |________|        :       :
%  |     | W(3,3) |               |  xn =[ :    x(1,t2)] = [x((i-1)*t2+j)]
%  |     |________|               |        :    x(2, 1)
%  |             ...              |        :       :
%  |               ...    ________|        :    x(2,t2)
%  |                     |W(t1,t2)|        :       :
%  |                     |        |    xt1*t2 = x(t1,t2)
%  |_____________________|________| 

% block B----(2*Wa+1:3*Wa,2*Wa+1:3*Wa)-------------------------------------
% A Window       5*Wa           (bk = 5)
%           __ __ __ __ __
%          |__|__|__|__|__|      
%          |__|__|__|__|__| 2*Wa+1  
%   5*Wa   |__|__|[]|__|__|   :       []: central block B 
%          |__|__|__|__|__|  3*Wa        = Window(2*Wa+1:3*Wa,2*Wa+1:3*Wa)   
%          |__|__|__|__|__|               
%            2*Wa+1 : 3*Wa

% Bigim Big----------------------------------------------------------------
%  __ __ __ __ __ __ __ __ __
% |2Wa^2|    2Wa*n     |     | (1:2*Wa) (2*Wa+1:2*Wa+n) (2*Wa+n+1:4*Wa+n)     
% |__ __|__ __ __ __ __|__ __|     A11        B1         A12    (1:2*Wa)
% |     |              |     |      
% |     |              |     |      
% |2Wa*m|   Im(m*n)    |     |     B2         Im          B3    (2*Wa+1:2*Wa+m)
% |     |              |     |      
% |__ __|__ __ __ __ __|__ __|      
% |     |              |     |     A21        B4         A22    (2*Wa+m+1:4*Wa+m)
% |__ __|__ __ __ __ __|__ __ v|
% < fmincon >--------------------------------------------------------------
%          c(x) < = 0
%          ceq(x) = 0
% min f =  A¡Px < = 0 
%  x       Aeq¡Px = beq
%          lb < = x < = ub 
%





