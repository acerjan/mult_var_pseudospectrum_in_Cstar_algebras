
syms x y z real
assumeAlso( x >= -1)
assumeAlso( x <= 1)
assumeAlso( y >= -1)
assumeAlso( y <= 1)
assumeAlso( z >= -1)
assumeAlso( z <= 1)


s1 = (x^2 - 2*(x^2 + 2*x*y*z + y^2 - z^2 + 1)^(1/2) + y^2 + 2)^(1/2)


z0 = x*y;

s1_middle = subs(s1,z, z0)
simplify(s1_middle)
latex(s1_middle)

z0 = min(z0,1)
z0 = max(z0,-1)
s1 = subs(s1,z, z0)


t1 = (x-1)^2+(y-1)^2;
t1 = min(t1,(x-1)^2+(y+1)^2);
t1 = min(t1,(x+1)^2+(y-1)^2);
t1 = min(t1,(x+1)^2+(y+1)^2);
t1 = sqrt(t1)

range = [-1.25 1.25 -1.25 1.25];

file_name_base = 'bothPS_u_v_universal';
image_file_name = strcat(file_name_base,num_label,'.pdf');
fig = figure

hold on
fsurf(s1,range)
fsurf(t1,range)
xlim([-1.25 1.25])
ylim([-1.25 1.25])
zlim([0 1.5])
view(15,23)

xlabel('$x$','interpreter','latex','FontSize',18 ) 
ylabel('$y$','interpreter','latex','rotation',0,'FontSize',18 ) 
zlabel('$z$','interpreter','latex','rotation',0,'FontSize',18 ) 
	
daspect([1 1 1])

drawnow
exportgraphics(fig,image_file_name,'Resolution',300)

