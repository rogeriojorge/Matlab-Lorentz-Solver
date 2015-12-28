function [] = Lorentz_video(ssolver,bbfunc,traj,T,np,nstep,xmax,xmin,ymax,ymin,zmax,zmin,dimensions,pos,E)

vid = VideoWriter(['Results/Lorentz_',dimensions,'_',ssolver,'_',bbfunc,'_E',num2str(sum(E)./1e5),'_',num2str(np),'particles.mp4']);
vid.Quality=85;
open(vid);
for istep=1:nstep
    [xmax,xmin,ymax,ymin,zmax,zmin]=Lorentz_visualize(traj(1:istep,:,:),T,np,xmax,xmin,ymax,ymin,zmax,zmin,dimensions,pos(istep,:,:));
    writeVideo(vid,getframe(gcf));
end
close(vid);
export_fig(['Results/Lorentz_',dimensions,'_',ssolver,'_',bbfunc,'_E',num2str(sum(E)./1e5),'_',num2str(np),'particles.pdf']);

end

