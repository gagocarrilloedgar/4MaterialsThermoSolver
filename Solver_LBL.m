function [T]=Solver_LBL(T,Tbef,aw,ae,as,an,ap,bp,delta,M,N)

Tant=Tbef;
finish=false;

while finish==false 
    
    P=zeros(sum(N),sum(M));
    Q=zeros(sum(N),sum(M));
    BP=zeros(sum(N),sum(M));
    Tnew=zeros(sum(N),sum(M));

for j=1:sum(M) % from bottom to top (the south temperatures will be actualized)
        
        % TDMA for a line j %
        [P,Q,Tnew,Tant,BP]=TDMA(aw,ae,as,an,ap,bp,j,N,M,P,Q,Tnew,Tant,BP); %We create the P and Q coefficients for the line j
        
        Tnew(sum(N),j)=Q(sum(N),j); %initializes here because the T(sum(N)+2) doesn't exist
        for i=(sum(N)-1):(-1):1
            Tnew(i,j)=P(i,j)*Tnew(i+1,j)+Q(i,j);
        end
        
end 

%% Convergence %%
if max(abs(Tant-Tnew))<delta
    finish=true;
    T=Tnew;
else 
    Tant=Tnew;
end

end
end

