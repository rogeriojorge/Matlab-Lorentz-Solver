function [xmax,xmin,ymax,ymin,zmax,zmin]=Lorentz_visualize(traj,T,np,xmax,xmin,ymax,ymin,zmax,zmin,dimensions,position)

maxpos=max(position);minpos=min(position);
if maxpos(1)>xmax
    xmax=2*xmax;
    xmin=2*xmin;
end
if minpos(1)<xmin
    xmax=2*xmax;
    xmin=2*xmin;
end
if maxpos(2)>ymax
    ymax=2*ymax;
    ymin=2*ymin;
end
if minpos(2)<ymin
    ymax=2*ymax;
    ymin=2*ymin;
end
if maxpos(3)>zmax
    zmax=2*zmax;
    zmin=2*zmin;
end
if minpos(3)<zmin
    zmax=2*zmax;
    zmin=2*zmin;
end

if strcmp(dimensions,'xyz')
    plot3(traj(:,:,1),traj(:,:,2),traj(:,:,3),'.','markers',4);
    axis([xmin xmax ymin ymax zmin zmax]);
    Lorentz_plot(['Temperature = ',num2str(T),' K, Number of Particles = ',num2str(np)],'x (m)','y (m)',0   ,''      ,'z (m)')
elseif strcmp(dimensions,'xy')
    plot(traj(:,:,1),traj(:,:,2)'.','markers',6);
    axis([xmin xmax ymin ymax]);
    Lorentz_plot(['Temperature = ',num2str(T),' K, Number of Particles = ',num2str(np)],'x (m)','y (m)',0,'')
elseif strcmp(dimensions,'yz')
    plot(traj(:,:,2),traj(:,:,3)'.','markers',6);
    axis([ymin ymax zmin zmax]);
    Lorentz_plot(['Temperature = ',num2str(T),' K, Number of Particles = ',num2str(np)],'y (m)','z (m)',0,'')
elseif strcmp(dimensions,'xz')
    plot(traj(:,:,1),traj(:,:,3)'.','markers',6);
    axis([xmin xmax zmin zmax]);
    Lorentz_plot(['Temperature = ',num2str(T),' K, Number of Particles = ',num2str(np)],'x (m)','z (m)',0,'')
end

end