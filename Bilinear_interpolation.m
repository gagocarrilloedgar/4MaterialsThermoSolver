function [Txy]=Bilinear_interpolation(T,x,y,X,Y)

[rx, cx]=min(abs(X-x));
[ry,cy]=min(abs(Y-y));

%This last peration can give us the umber pof the right or of the left to
%the x we are searching. The formula below operates with cx=position of the number to the left 
if x-X(cx)<0%If the number given is the one of the right
    cx=cx-1;%We know the number of the left would be one position below the one calculated
end

if y-Y(cy)<0
    cy=cy-1;%we operate with the number smaller to the x we are searching
end

Tmatrix=[T(cx,cy),T(cx,cy+1);
         T(cx+1,cy),T(cx+1,cy+1)];

Xarray=[X(cx+1)-x, x-X(cx)];

Yarray=[Y(cy+1)-y,y-Y(cy)];
     
Txy=(1/((X(cx+1)-X(cx))*(Y(cy+1)-Y(cy))))*Xarray*Tmatrix*Yarray';

end
    
