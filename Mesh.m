function [X,Y,Rx,Ry,V,LAMBDA,Sx,Sy,lambx,lamby,Cp,rho]=Mesh(COOR,N,M,W,Mat)
%% MESH GENERATOR %%

[px,py]=coordinates(COOR); %extracts the coordinates x and y that do not repeat 

%% Increments %%
IncX(1)=px(1)/N(1);
for i=2:size(px,2)
    IncX(i)=(px(i)-px(i-1))/N(i);
end

IncY(1)=py(1)/M(1);
for i=2:size(py,2)
    IncY(i)=(py(i)-py(i-1))/M(i);
end

%% Faces %%

Rx=zeros(1,N(1)+N(2)+1);
Rx(1)=0;
for i=2:N(1)
       Rx(i)=IncX(1)+Rx(i-1);
end
Rx(N(1)+1)=px(1);
for i=N(1)+2:N(1)+N(2)
       Rx(i)=IncX(2)+Rx(i-1);
end
Rx(N(1)+N(2)+1)=px(2);

Ry=zeros(1,M(1)+M(2)+M(3)+1);
Ry(1)=0;
for i=2:M(1)
       Ry(i)=IncY(1)+Ry(i-1);
end
Ry(M(1)+1)=py(1);
for i=M(1)+2:M(1)+M(2)
       Ry(i)=IncY(2)+Ry(i-1);
end
Ry(M(1)+M(2)+1)=py(2);
for i=M(1)+M(2)+2:M(1)+M(2)+M(3)
       Ry(i)=IncY(3)+Ry(i-1);
end
Ry(M(1)+M(2)+M(3)+1)=py(3);

%% Nodes %%

X=zeros(1,N(1)+N(2));
for i=1:(N(1)+N(2))
    X(i)=Rx(i)+(Rx(i+1)-Rx(i))/2;
end

Y=zeros(1,M(1)+M(2)+M(3));
for i=1:(M(1)+M(2)+M(3))
    Y(i)=Ry(i)+(Ry(i+1)-Ry(i))/2;
end


%% Volumes %%
V=zeros(size(Ry,2)-1,size(Rx,2)-1);
for i=2:size(Ry,2)
    
    for j=2:size(Rx,2)
        V(i-1,j-1)=(Rx(j)-Rx(j-1))*(Ry(i)-Ry(i-1))*W;
    end
    
end
V=V';

%% Surfaces %%

Sx=zeros(size(X,2)-1,size(Y,2));
Sy=zeros(size(Y,2)-1,size(X,2));

for j=1:(size(Y,2))
    for i=1:(size(X,2)-1)
       Sx(i,j)=(Ry(j+1)-Ry(j))*W;
    end
end

for j=1:(size(X,2))
    for i=1:(size(Y,2)-1)
       Sy(i,j)=(Rx(j+1)-Rx(j))*W;
    end
end
Sy=Sy';

%% Lambda division %%
LAMBDA=zeros(sum(N),sum(M));
LAMBDA(1:N(1),1:M(1))=Mat(1,3);
LAMBDA(N(1)+1:(N(1)+N(2)),1:(M(1)+M(2)))=Mat(2,3);
LAMBDA(1:N(1),(M(1)+1):(M(1)+M(2)+M(3)))=Mat(3,3);
LAMBDA((N(1)+1):(N(1)+N(2)),(M(1)+M(2)+1):(M(1)+M(2)+M(3)))=Mat(4,3);

%% Lambda harmonica %%
lambx=zeros(size(X,2)-1,size(Y,2));
lamby=zeros(size(X,2),size(Y,2)-1);
for j=1:size(Y,2)    
    for i=2:size(X,2)
       lambx(i-1,j)=(X(i)-X(i-1))/(((X(i)-Rx(i))/LAMBDA(i,j))+((Rx(i)-X(i-1))/LAMBDA(i-1,j)));
    end
end

for i=1:size(X,2)    
    for j=2:size(Y,2)
       lamby(i,j-1)=(Y(j)-Y(j-1))/(((Y(j)-Ry(j))/LAMBDA(i,j))+((Ry(j)-Y(j-1))/LAMBDA(i,j-1)));
    end
end

%% Cp division %%
Cp=zeros(sum(N),sum(M));
Cp(1:N(1),1:M(1))=Mat(1,2);
Cp(N(1)+1:(N(1)+N(2)),1:(M(1)+M(2)))=Mat(2,2);
Cp(1:N(1),(M(1)+1):(M(1)+M(2)+M(3)))=Mat(3,2);
Cp((N(1)+1):(N(1)+N(2)),(M(1)+M(2)+1):(M(1)+M(2)+M(3)))=Mat(4,2);

%% Rho division %%
rho=zeros(sum(N),sum(M));
rho(1:N(1),1:M(1))=Mat(1,1);
rho(N(1)+1:(N(1)+N(2)),1:(M(1)+M(2)))=Mat(2,1);
rho(1:N(1),(M(1)+1):(M(1)+M(2)+M(3)))=Mat(3,1);
rho((N(1)+1):(N(1)+N(2)),(M(1)+M(2)+1):(M(1)+M(2)+M(3)))=Mat(4,1);

end














    







