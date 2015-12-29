function [ Bfield ] = Lorentz_Bfield(position,bfunc,np,L)

Bfield=zeros(np,3);

if bfunc==1
    Bfield(:,3)=ones(np,1);
elseif bfunc==2
    Bfield(:,3)=1+cos(2*pi.*position(:,2)./L);
elseif bfunc==3
    Bfield(:,3)=L./abs(position(:,3));
end

