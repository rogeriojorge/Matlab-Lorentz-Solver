function [] = Lorentz_MBDist_histogram(vel,vth,bbfunc,E,np)

[n,x]=hist(vel(1,:,1),50);
yvel=n/length(vel(1,:,1))/diff(x(1:2));
pd=fitdist(vel(1,:,1)','Normal');
[mu,sigma]=normfit(vel(1,:,1));
xpdf=x(1):1:x(end);
ypdf = pdf(pd,xpdf);
close all;bar(x,yvel,'FaceColor',[.9 .5 .1],'EdgeColor',[.8 .4 .1],'LineWidth',0.1);hold on;plot(xpdf,ypdf,'Color',[0,0.7,0.9],'LineWidth',2);
hLegend=legend('Particle X Velocity','Fit to Normal Distribution');
set(hLegend,'FontName','AvantGarde','FontSize',6);
Lorentz_plot(['\mu/v_{th}=',num2str(mu/vth),', \sigma/v_{th}=',num2str(sigma/vth)],'$v_x$',[num2str(np),' particles - f(vx)'],1,['Results/Distribution_',bbfunc,'_E',num2str(sum(E)./1e5),'_',num2str(np),'particles'],np);
close all;
end