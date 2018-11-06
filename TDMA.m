function [P,Q,Tnew,Tant,BP]=TDMA(aw,ae,as,an,ap,bp,j,N,M,P,Q,Tnew,Tant,BP)
    
    if j==1 %At the bottom the temperature is fixed
        
            for i=1:sum(N)
                Q(i,j)=bp(i,j);
                P(i,j)=0;
            end
            
    elseif j==sum(M)
            
            %Left side
            BP(1,j)=bp(1,j)+as(1,j)*Tnew(1,j-1);
            P(1,j)=ae(1,j)/ap(1,j);
            Q(1,j)=BP(1,j)/ap(1,j);
    
            %Inside 
            for i=2:(sum(N)-1)
              BP(i,j)=bp(i,j)+as(i,j)*Tnew(i,j-1);
        
              P(i,j)=ae(i,j)/(ap(i,j)-aw(i,j)*P(i-1,j));
              Q(i,j)=(BP(i,j)+aw(i,j)*Q(i-1,j))/(ap(i,j)-aw(i,j)*P(i-1,j));
        
            end
    
            %Right side: fixed temperature
            P(sum(N),j)=0;
            Q(sum(N),j)=bp(sum(N),j);
    else 
       
            %Left side
            BP(1,j)=bp(1,j)+as(1,j)*Tnew(1,j-1)+an(1,j)*Tant(1,j+1);
            P(1,j)=ae(1,j)/ap(1,j);
            Q(1,j)=BP(1,j)/ap(1,j);

            %Inside 
            for i=2:(sum(N)-1)
                BP(i,j)=bp(i,j)+as(i,j)*Tnew(i,j-1)+an(i,j)*Tant(i,j+1);

                P(i,j)=ae(i,j)/(ap(i,j)-aw(i,j)*P(i-1,j));
                Q(i,j)=(BP(i,j)+aw(i,j)*Q(i-1,j))/(ap(i,j)-aw(i,j)*P(i-1,j));

            end

            %Right side: fixed temperature
            P(sum(N),j)=0;
            Q(sum(N),j)=bp(sum(N),j);
            
    end

end

    
    
    
    