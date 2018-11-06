function [aw,ae,as,an,ap,bp]=Coefficients(X,Y,Sx,Sy,lambx,lamby,Qtop,Tleft,alpha,Rx,Tbef,Cp,rho,V,M,N,w,t,Tbott)

ae=zeros(size(X,2),size(Y,2));
aw=zeros(size(X,2),size(Y,2));
an=zeros(size(X,2),size(Y,2));
as=zeros(size(X,2),size(Y,2));
ap=zeros(size(X,2),size(Y,2));
bp=zeros(size(X,2),size(Y,2));

for j=2:(size(Y,2)-1)
  for i=2:(size(X,2)-1)  %Coefficients of the nodes of the boundary will be defined later
    
    aw(i,j)=(lambx(i-1,j)*Sx(i-1,j))/(X(i)-X(i-1));
    ae(i,j)=(lambx(i,j)*Sx(i,j))/(X(i+1)-X(i));
    an(i,j)=(lamby(i,j)*Sy(i,j))/(Y(j+1)-Y(j));
    as(i,j)=(lamby(i,j-1)*Sy(i,j-1))/(Y(j)-Y(j-1));
    bp(i,j)=rho(i,j)*Cp(i,j)*V(i,j)*Tbef(i,j); %the increment of time is 1 sec, all this term is divided by 1
    
    ap(i,j)=aw(i,j)+ae(i,j)+an(i,j)+as(i,j)+rho(i,j)*Cp(i,j)*V(i,j);
    
  end
end

%% Boundary conditions %%

%Corner bottom, left
ae(1,sum(M))=(lambx(1,sum(M))*Sx(1,sum(M)))/(X(2)-X(1));
as(1,sum(M))=(lamby(1,sum(M)-1)*Sy(1,sum(M)-1))/(Y(sum(M))-Y(sum(M)-1));
ap(1,sum(M))=ae(1,sum(M))+as(1,sum(M))+alpha*Sx(1,sum(M))+rho(1,sum(M))*Cp(1,sum(M))*V(1,sum(M));
bp(1,sum(M))=Qtop*(Rx(2)-Rx(1))+Tleft*alpha*Sx(1,sum(M))+rho(1,sum(M))*Cp(1,sum(M))*V(1,sum(M))*Tbef(1,sum(M));

%Left wall
for j=2:sum(M)-1
    ae(1,j)=(lambx(1,j)*Sx(1,j))/(X(2)-X(1));
    as(1,j)=(lamby(1,j-1)*Sy(1,j-1))/(Y(j)-Y(j-1));
    an(1,j)=(lamby(1,j)*Sy(1,j))/(Y(j+1)-Y(j));
    ap(1,j)=ae(1,j)+an(1,j)+as(1,j)+alpha*Sx(1,j)+rho(1,j)*Cp(1,j)*V(1,j);
    bp(1,j)=Tleft*alpha*Sx(1,j)+rho(1,j)*Cp(1,j)*V(1,j)*Tbef(1,j);
end

%Top
for i=2:sum(N)-1
    ae(i,sum(M))=(lambx(i,sum(M))*Sx(i,sum(M)))/(X(i+1)-X(i));
    as(i,sum(M))=(lamby(i,sum(M)-1)*Sy(i,sum(M)-1))/(Y(sum(M))-Y(sum(M)-1));
    aw(i,sum(M))=(lambx(i-1,sum(M))*Sx(i-1,sum(M)))/(X(i)-X(i-1));
    ap(i,sum(M))=ae(i,sum(M))+aw(i,sum(M))+as(i,sum(M))+rho(i,sum(M))*Cp(i,sum(M))*V(i,sum(M));
    bp(i,sum(M))=Qtop*(Rx(i+1)-Rx(i))+rho(i,sum(M))*Cp(i,sum(M))*V(i,sum(M))*Tbef(i,sum(M));
end

%Corner bottom, right
bp(sum(N),sum(M))=(8+0.005*t(w))+273;
ap(sum(N),sum(M))=1;

%Bottom
bp(1:sum(N),1)=Tbott;
ap(1:sum(N),1)=1;

%Right wall
bp(sum(N),2:sum(M)-1)=(8+0.005*t(w))+273;
ap(sum(N),2:sum(M)-1)=1;

end

