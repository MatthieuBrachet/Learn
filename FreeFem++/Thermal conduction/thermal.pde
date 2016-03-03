func u0=10+90*x/6;
func k = 1.8*(y<0.5)+0.2;
real ue=25, alpha=0.25, T=5, dt=0.1;

mesh Th=square(30,5,[6*x,y]);
plot(Th, wait=1);

fespace Vh(Th,P2);
Vh u=u0,v,uold;

problem thermic(u,v)=int2d(Th)(u*v/dt + k*(dx(u)*dx(v)+dy(u)*dy(v)))
	+ int1d(Th,1,3)(alpha*u*v)
	- int1d(Th,1,3)(alpha*ue*v)
	- int2d(Th)(uold*v/dt)
	+ on(2,4,u=u0);
ofstream aa("thermic.dat");
for (real t=0;t<T; t+=dt){
	uold = u;
	thermic;
	aa<<u(3,0.5)<<endl;
	plot(u);
}
