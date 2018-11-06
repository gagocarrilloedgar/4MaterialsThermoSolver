
%% Physical data %%

    % X(m)   Y(m)
COOR = [0.5    0.4;  %p1
        0.5    0.7;  %p2
        1.1    0.8];  %p3

   %   rho     cp      lambda
Mat = [1500    750     170;
       1600    770     140;
       1900    810     200;
       2500    930     140];

W=1; %width

%% Boundary conditions %%

Tbott=296; %K isothermic (adiabatic)
Qtop=60; %W/m
Tleft=306; %K
alpha=9; %W/m2K
%Tright Depends on time

%% Code data %%


N=[27  33]; %Nodes in material M1,M2,M3,M4 in the x direction equally divided to reach 60 nodes in total
M=[30  22  8]; %Nodes in material M1,M2,M3,M4 in the y direction

Tini=281; %K

delta=1e-3; %how close the result is to the real solution 
fr=1; %relaxing factor
seconds=10000;



