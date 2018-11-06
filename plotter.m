function plotter(t,p1,p2,T,w)

%% Points of interest %%
time=1:(t(w)+1);

plot(time,p1);
hold on;
plot(time,p2);

legend('(0.65,0.56)','(0.74,0.72)');
xlabel('Time in seconds');
ylabel('Temperature in ºC');

%% Temperature plot %%
figure;
[m,n]=size(T);
[x,y]=meshgrid(1:n,1:m);
surf(x,y,T);
shading interp;

title('Surface change of temperatures');
zlabel('Temperature in ºC');
q=colorbar;
q.Label.String='Temperature in ºC';

figure;
pcolor(T');
shading interp;

title('Map of temperatures in the fin');
c=colorbar;
c.Label.String='Temperature in ºC';

end
