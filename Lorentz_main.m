function [pos,vel,traj,err]=Lorentz_main(np,bfunc,E,nstep,solver,ssolver,dt,q_over_m,vth,L,dimensions,bbfunc)

position = (rand(np,3)-0.5)*2*L;
velocity = randn(np,3)*vth;
initialenergy = sum(sum(velocity.^2));

time = 0.0;
pos=zeros(nstep-1,np,3);vel=pos;
Erep=repmat(E,np,1);
err=zeros(nstep-1,1);

%@ Loop over time steps to compute the motion
for istep=1:nstep
    Bfield = Lorentz_Bfield(position,bfunc,np,L);
    [position,velocity,time]=Lorentz_dsolve(solver,q_over_m,Erep,velocity,Bfield,dt,position,time);
    
    pos(istep,:,:)=position;
    vel(istep,:,:)=velocity;
    if sum(E)==0
        err(istep)=abs(sum(sum(velocity.^2))-initialenergy)/initialenergy;
    end
end

dr=zeros(nstep,np,3);
dr(2:end,:,:)=diff(pos);
traj=pos+dr;

hdf5write(['Results/Lorentz_',dimensions,'_',ssolver,'_',bbfunc,'_E',num2str(sum(E)./1e5),'_',num2str(np),'particles.h5'], '/position', pos);
hdf5write(['Results/Lorentz_',dimensions,'_',ssolver,'_',bbfunc,'_E',num2str(sum(E)./1e5),'_',num2str(np),'particles.h5'], '/velocity', vel, 'WriteMode', 'append');
hdf5write(['Results/Lorentz_',dimensions,'_',ssolver,'_',bbfunc,'_E',num2str(sum(E)./1e5),'_',num2str(np),'particles.h5'], '/trajectory', traj, 'WriteMode', 'append');
hdf5write(['Results/Lorentz_',dimensions,'_',ssolver,'_',bbfunc,'_E',num2str(sum(E)./1e5),'_',num2str(np),'particles.h5'], '/error', err, 'WriteMode', 'append');

end

