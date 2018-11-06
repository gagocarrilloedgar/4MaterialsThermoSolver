
%Setting the inital parameters in order to compute the eq in time
w=1;
t(w)=0;
[T]=Initialmap(Tini,X,Y); %Temperatures at t=0
stop=false;
Tbef=T;