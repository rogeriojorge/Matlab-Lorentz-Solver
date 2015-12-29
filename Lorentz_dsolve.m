function [ position,velocity,time] = Lorentz_dsolve(solver,q_over_m,Erep,velocity,BB,dt,position,time)

if solver==1
        k1 = q_over_m * (Erep + cross(velocity,BB));
        k2 = q_over_m * (Erep + cross(velocity+0.5.*dt.*k1,BB));
        k3 = q_over_m * (Erep + cross(velocity+0.5.*dt.*k2,BB));
        k4 = q_over_m * (Erep + cross(velocity+dt.*k3,BB)); 
        velocity = velocity + (1/6).*(k1+2.*k2+2.*k3+k4).*dt;
        position = position + dt.*velocity;
        time = time + dt;
elseif solver==2
        acceleration = q_over_m * (Erep + cross(velocity,BB));
        velocity = velocity + dt.*acceleration;
        position = position + dt.*velocity;
        time = time + dt;
end

end

