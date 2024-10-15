function one_shift


file_name_base = 'one_shft';




syms x y z  real

v0 = [(1-z)/x; x+(1-z)^2/x]
M = [1/x -z/x; -z/x (x^2+z^2)/x]
v1 = M*v0;

v0 = simplify(v0)
v1 = simplify(v1)

paraEQ = (v1(1))/(v0(1)) - (v1(2))/(v0(2))

paraEQ = simplifyFraction(paraEQ)

paraEQ = simplifyFraction(x*(1 - z)*paraEQ)

expand((v0(1))*(x^2))
expand((v1(1))*(x^2))

f = expand((v0(1))*(x^2) - (v1(1))*(x^2))

f_dz = diff(f,z)

simplify( f_dz - (x-1/2)^2 - 3*(z-4/6)^2 - 5/12 ) 

paraEQ

[e,denomenator] = numden(paraEQ);
e = -e


q = (x^4 - e)^(1/4)
q = simplify(q)
	
f_on_e = subs(f,x,q)
f_on_e = simplify(f_on_e, 'Steps',250)


two_curves_file_name = strcat(file_name_base,'_','e_and_f','.pdf');
	
fig = figure
set(fig , 'Position',  [0, 0, 200, 400])

x_min = 0;
x_max = 2.2;
z_min = -0.2;
z_max = 3.0;


hold on
fimplicit(f,[x_min x_max z_min z_max],'--b','LineWidth',1)
fimplicit(paraEQ,[x_min x_max z_min z_max],'-k','LineWidth',1)
	
xlim([x_min x_max]);
ylim([z_min z_max]);


xlabel('$x$','interpreter','latex','FontSize',18 ) 
ylabel('$z$','interpreter','latex','rotation',0,'FontSize',18 ) 
zlabel('$z$','interpreter','latex','rotation',0,'FontSize',18 ) 


drawnow
exportgraphics(fig,two_curves_file_name)

	

%{
figure
paraEQ_3D = subs(paraEQ,x^2,x^2+y^2)
fimplicit3(paraEQ_3D,[-1 1 -1 1 0 1])
xlim([-1.2 1.2])
ylim([-1.2 1.2])
zlim([-0.2 1.2])
view([-18 20])
xlabel('$x$','interpreter','latex','rotation',0,'FontSize',18 ) 
ylabel('$y$','interpreter','latex','rotation',0,'FontSize',18 ) 
zlabel('$z$','interpreter','latex','rotation',0,'FontSize',18 ) 
%}


end
