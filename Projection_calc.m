syms theta real
syms x y z real

assumeAlso( z >= 0)
assumeAlso( z <= 1)

P = [1 0; 0 0]
Q = [1-z sqrt(z - z^2);sqrt(z - z^2) z]
X = [x 0; 0 x]
Y = [y 0; 0 y]

PP = expand((P - X)^2)
latex(PP)

QQ = expand((Q - Y)^2)
latex(QQ)

MM = simplify(PP+QQ)
latex(MM)


tall = eig(MM)
tall = simplify(tall,'Steps',300)

t1 = tall(2)


tsimple = x^2+y^2-x-y+1-sqrt((x+y)^2-2*y-2*x+1-(2*x-1)*(2*y-1)*z)
check_t = expand(t1 - tsimple)

t1 = sqrt(t1);

latex(tsimple)




L = (P - X) +i*(Q - Y)

sall = simplify(svd(L),'Steps',30)

s1 = sall(1)
latex(s1)

ssimple = sqrt(x^2+y^2-x-y+1-sqrt((x+y)^2-2*y-2*x+1-(2*x-1)*(2*y-1)*z +z -z^2))
check_s = simplify(s1 - ssimple)


range = [0 1 0 1];

for z0 = 0:0.25:1;
	figure
	view(15,23)
	hold on

	fs = subs(s1,z,z0)
	fs = simplify(fs)
	fsurf(fs,range)

	ft = subs(t1,z,z0)
	ft = simplify(ft)
	fsurf(ft,range)

	zlim([0,1])
	
end

