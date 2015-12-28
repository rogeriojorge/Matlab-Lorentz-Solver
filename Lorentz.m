function []=Lorentz

% lorentz - Program to compute the motion of many electrons in
%           an E and B field using the Runge-Kutta or Euler method
help lorentz;  % Clear memory and print header
addpath exportfig
%@ Ask for user input
testmode = input('Quick test mode: 1 for yes, 0 for no - ');
mass = 9.10939e-31;     % Mass of electron (kg)
q = 1.602177e-19;       % Charge of electron (C)
kb = 1.38065e-23;       % Boltzmann constant (SI)
dt = 2*pi*mass/q/100;
q_over_m = q/mass;
if testmode == 0
    np = input('Enter number of particles - ');
    T = input('Particle temperature (K) - ');
    bfunc= input('Bfield with 1 T on z: 1 for uniform, 2 for cosine, 3 for 1/r - ');
    E = input('Enter electric field direction [Ex Ey Ez] (kV/cm) - ');
    E=E.*1e5;
    solver = input('Solver: 1 for RK4, 2 for Euler - ');
    plane = input('Plane: 1 for xy, 2 for xz, 3 for yz, 4 for xyz - ');
    nstep = input('Number of time steps - ');

    if solver==1
        ssolver='RK4';
    elseif solver==2
        ssolver='Euler';
    end
    
    if bfunc==1
       bbfunc='unifB';
    elseif bfunc==2
        bbfunc='cosB';
    elseif bfunc==3
        bbfunc='1overLB';
    end
    
    if plane==1
        dimensions='xy';
    elseif plane==2
        dimensions='xz';
   elseif plane==3
       dimensions='yz';
    elseif plane==4
        dimensions='xyz';
    end
    
    vth=sqrt(2*kb*T/mass);
    L = 10*vth*mass/q;
    xmax=1.5*L;xmin=-xmax;ymax=xmax;ymin=xmin;zmax=xmax;zmin=xmin;
    
    [pos,~,traj,~]=Lorentz_main(np,bfunc,E,nstep,solver,ssolver,dt,q_over_m,vth,L,dimensions,bbfunc);
    Lorentz_video(ssolver,bbfunc,traj,T,np,nstep,xmax,xmin,ymax,ymin,zmax,zmin,dimensions,pos,E);
    
elseif testmode == 1
    np = 10;
    T = 1000;
    bfunc = 1;
    bbfunc='unifB';
    E = [0 0 0];
    dimensions='xyz';
    nstep = 2000;
    solver = 1;
    ssolver='RK4';
  
    vth=sqrt(2*kb*T/mass);
    L = 10*vth*mass/q;
    xmax=1.5*L;xmin=-xmax;ymax=xmax;ymin=xmin;zmax=xmax;zmin=xmin;
    
    [pos,~,traj,err1]=Lorentz_main(np,bfunc,E,nstep,solver,ssolver,dt,q_over_m,vth,L,dimensions,bbfunc);
    Lorentz_video(ssolver,bbfunc,traj,T,np,nstep,xmax,xmin,ymax,ymin,zmax,zmin,dimensions,pos,E);
	loglog(err1);Lorentz_plot('Relative error with Runge-Kutta method','timesteps','$\frac{|E-E_0|}{E_0}$',1,['Results/energy_error_',ssolver]);

    solver = 2;
    ssolver='Euler';
    xmax=1.5*L;xmin=-xmax;ymax=xmax;ymin=xmin;zmax=xmax;zmin=xmin;
    
    [pos,~,traj,err]=Lorentz_main(np,bfunc,E,nstep,solver,ssolver,dt,q_over_m,vth,L,dimensions,bbfunc);
    Lorentz_video(ssolver,bbfunc,traj,T,np,nstep,xmax,xmin,ymax,ymin,zmax,zmin,dimensions,pos,E);
    loglog(err);Lorentz_plot('Relative error with Euler method','timesteps','$\frac{|E-E_0|}{E_0}$',1,['Results/energy_error_',ssolver]);
    
    close all;
    loglog(err1);hold on;loglog(err);Lorentz_plot('','timesteps','$\frac{|E-E_0|}{E_0}$',1,'Results/energy_error_both');
    close all;
    
    E = [0 5e5 0];
    solver = 1;
    ssolver='RK4';
    xmax=1.5*L;xmin=-xmax;ymax=xmax;ymin=xmin;zmax=xmax;zmin=xmin;
    dimensions='xy';
    [pos,~,traj,~]=Lorentz_main(np,bfunc,E,nstep,solver,ssolver,dt,q_over_m,vth,L,dimensions,bbfunc);
    Lorentz_video(ssolver,bbfunc,traj,T,np,nstep,xmax,xmin,ymax,ymin,zmax,zmin,dimensions,pos,E);
    
    E = [0 0 0];
    bfunc = 2;
    bbfunc='cosB';
    xmax=1.5*L;xmin=-xmax;ymax=xmax;ymin=xmin;zmax=xmax;zmin=xmin;
    dimensions='xy';
    [pos,~,traj,~]=Lorentz_main(np,bfunc,E,nstep,solver,ssolver,dt,q_over_m,vth,L,dimensions,bbfunc);
    Lorentz_video(ssolver,bbfunc,traj,T,np,nstep,xmax,xmin,ymax,ymin,zmax,zmin,dimensions,pos,E);
    
    bfunc = 1;
    bbfunc='unifB';
    nstep = 2;
    np = 100000;
    [~,vel,~,~]=Lorentz_main(np,bfunc,E,nstep,solver,ssolver,dt,q_over_m,vth,L,dimensions,bbfunc);
    Lorentz_MBDist_histogram(vel,vth,bbfunc,E,np);
    np = 10000;
    [~,vel,~,~]=Lorentz_main(np,bfunc,E,nstep,solver,ssolver,dt,q_over_m,vth,L,dimensions,bbfunc);
    Lorentz_MBDist_histogram(vel,vth,bbfunc,E,np);
    np = 1000;
    [~,vel,~,~]=Lorentz_main(np,bfunc,E,nstep,solver,ssolver,dt,q_over_m,vth,L,dimensions,bbfunc);
    Lorentz_MBDist_histogram(vel,vth,bbfunc,E,np);
    np = 100;
    [~,vel,~,~]=Lorentz_main(np,bfunc,E,nstep,solver,ssolver,dt,q_over_m,vth,L,dimensions,bbfunc);
    Lorentz_MBDist_histogram(vel,vth,bbfunc,E,np);
end