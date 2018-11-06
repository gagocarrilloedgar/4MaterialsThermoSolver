%% Core

while stop==false

%% Calculate coefficients %%
[aw,ae,as,an,ap,bp]=Coefficients(X,Y,Sx,Sy,lambx,lamby,Qtop,Tleft,alpha,Rx,Tbef,Cp,rho,V,M,N,w,t,Tbott);

%% Solver line-by-line %%   
[T]=Solver_LBL(T,Tbef,aw,ae,as,an,ap,bp,delta,M,N);

%% Saves the points %%
x=0.65; y=0.56;
[Txy]=Bilinear_interpolation(T,x,y,X,Y);
p1(t(w)+1)=Txy-273;

x=0.74; y=0.72;
[Txy]=Bilinear_interpolation(T,x,y,X,Y);
p2(t(w)+1)=Txy-273;

if t(w)>seconds
    stop=true;
else

Tbef=T; %If the loop doesn't stop we assign the temperature again

w=w+1;
t(w)=t(w-1)+1;
end


end