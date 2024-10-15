function variable_shift

file_name_base = 'varbl_shft';



syms x y z b real
assumeAlso(b >= 0)

v0 = [(b-z)/x; x+(b-z)^2/x];
M = [1/x -z/x; -z/x (x^2+z^2)/x];
v1 = M*v0;

v0 = simplifyFraction(v0);
v1 = simplifyFraction(v1);

paraEQ = (v1(1))/(v0(1)) - (v1(2))/(v0(2));

paraEQ = simplifyFraction(paraEQ);

paraEQ = simplifyFraction(x*(b - z)*paraEQ)


expand((v0(1))*(x^2));
expand((v1(1))*(x^2));

f = expand((v0(1))*(x^2) - (v1(1))*(x^2))

f_dz = diff(f,z)

simplify( f_dz - (x-1/2)^2 - 3*(z-4*b/6)^2 - 3/4 + b^2/3 ) ;

x_min = 0;
x_max = 2.2;
z_min = -0.2;
z_max = 3.0;

mymap = [0.7 0.7 1.0; 1 1 1];



digits_all = 005:005:225;
b0_all = digits_all/100;

clear Frames

filename_2D = 'e_and_f';
video_file_2D = VideoWriter(filename_2D,'Uncompressed AVI')
video_file_2D.FrameRate = 10;
open(video_file_2D)


clear Frames_3D

filename_3D = 'e_3D';
video_file_3D = VideoWriter(filename_3D,'Uncompressed AVI')
video_file_3D.FrameRate = 10;
open(video_file_3D)


for j = 1:length(b0_all);
	b0 = b0_all(j)
	digits=digits_all(j);
	
	numbr = int2str(digits);
	image_file_name = strcat(file_name_base,'_',numbr,'.pdf');
	ThreeD_file_name = strcat(file_name_base,'_','surface','_',numbr,'.pdf');

	fig = figure('Name', file_name_base);
	set(fig , 'Position',  [0, 0, 400, 600]);
	hold on
	
	f0 = subs(f,b,b0);
	F0 = matlabFunction(f0);
	delta = 0.002;
	xx = x_min:delta:x_max;
	zz = z_min:delta:z_max;
	[X,Z] = meshgrid(xx,zz);
	Fnumr = F0(X,Z);
	mask = -sign(Z - (b0 + delta/2)) ;
	Fnumr = Fnumr.*mask;
	Fnumr = double(Fnumr >= 0);

	Fnumr = Fnumr.*mask;
	s = pcolor(X,Z,Fnumr);
	colormap(mymap);
	shading interp ;


	
	pEQ = subs(paraEQ,b,b0);
	fimplicit(pEQ,[x_min x_max z_min z_max],'-k','LineWidth',1.5)
	
	xlim([x_min x_max]);
	ylim([z_min z_max]);
	
	xlabel('$x$','interpreter','latex','FontSize',20 ) ;
	ylh = ylabel('$z$','interpreter','latex','rotation',0,'FontSize',20) ;
	ylh.Position(2) = ylh.Position(2) - 0.2;  

	drawnow
	pause(0.1)
	
	Frames(j) = getframe(fig);
	writeVideo(video_file_2D,Frames(j))
	
	set(fig , 'Position',  [0, 0, 200, 400]);
	xlabel('$x$','interpreter','latex','FontSize',14 ) ;
	ylh = ylabel('$z$','interpreter','latex','rotation',0,'FontSize',14) ;
	ylh.Position(2) = ylh.Position(2) - 0.05;  
		
	exportgraphics(fig,image_file_name)


	close(fig)
	
	fig2 = figure('Name', file_name_base);
	set(fig2 , 'Position',  [0, 0, 400, 600]);

	paraEQ_3D = subs(pEQ,x^2,x^2+y^2);
	fimplicit3(paraEQ_3D,[-1 1 -1 1 0 b0])
	xlim([-1.2 1.2])
	ylim([-1.2 1.2])
	zlim([-0.2 2.5])
	view([-18 20])
	xlabel('$x$','interpreter','latex','rotation',0,'FontSize',18 ) 
	ylabel('$y$','interpreter','latex','rotation',0,'FontSize',18 ) 
	zlabel('$z$','interpreter','latex','rotation',0,'FontSize',18 ) 

	drawnow
	
	Frames_3D(j) = getframe(fig2);
	writeVideo(video_file_3D,Frames_3D(j))
	
	set(fig2 , 'Position',  [0, 0, 200, 300]);
	
	drawnow
	exportgraphics(fig2,ThreeD_file_name)
	pause(0.5)
	close(fig2)
end

for j = length(b0_all):-1:1
   writeVideo(video_file_2D,Frames(j))
   writeVideo(video_file_3D,Frames_3D(j))
end


close(video_file_2D)
close(video_file_3D)

end