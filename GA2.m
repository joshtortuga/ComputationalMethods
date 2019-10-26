format compact
format long
clc; clear;
close all

n = 10000;
yInitial = 3;
mass =1;
k =2;
dt = 0.005;
gravity = 9.81;

time = zeros(1,n);

position = zeros(1,n);
velocity = zeros(1,n);
accleration = zeros(1,n);
position(1) = yInitial;
velocity(1) = 0;
accleration(1) = -(k/yInitial)/mass;

exactposition = zeros(1,n);
exactvelocity = zeros(1,n);
exactposition(1) = yInitial;
exactvelocity(1)= 0;

for i=3:n+1
    time(i-1)=(i-1)*dt;
    
    accleration(i-1) = -(k*position(i-2))/mass;
    velocity(i-1) = (velocity(i-2))+(accleration(i-2)*dt);
    position(i-1)= (position(i-2))+(velocity(i-1)*dt);
        
    exactposition(i-1) = yInitial*cos((i-2)*sqrt(k/mass)*dt);
    exactvelocity(i-1) = -1*yInitial*sqrt(k/mass)*sin((i-2)*sqrt(k/mass)*dt);

end
    figure ('name','figure 1')
        subplot(2,1,1)
            plot(time,position,time, exactposition)
            title('Position vs. Time')
            xlabel('Time (s)')
            xlim([0 51])
            ylabel('Position (m)')
            legend({'Euler Position','Exact Position'},'Location',"eastoutside")
        subplot(2,1,2)    
            plot(time, velocity,time,exactvelocity)
            title('Velocity vs. Time')
            xlabel('Time (s)')
            xlim([0 51])
            ylabel('Velocity (m/s)') 
            legend({'Euler Velocity','Exact Velocity'},'Location',"eastoutside")
            
omega=sqrt(k/mass); % calculation to find omega
period=2*pi/omega; % calculation to find period
            
% Exercise 3: Energery in Euler Algorithm Model of SHO

energy = zeros(1,n);
exactenergy = zeros(1,n);

for i=3:n
    energy(i) = (.5*mass*(velocity(i))^2)+(mass*gravity*position(i))+(.5*k*(position(i))^2);
    exactenergy(i) = (.5*mass*(exactvelocity(i))^2)+(mass*gravity*exactposition(i))+(.5*k*(exactposition(i))^2);
end
    figure
        plot(time,energy,time,exactenergy)
        title('Energy vs. Time')
        xlabel('Time (s)')
        ylabel('Energy') 
        legend({'Energy','Exact Energy'},'Location',"eastoutside")
        
% Exercise 4: Euler-Cromer Algorithm Model of a SHO
x= n-1;
eulercromerposition = zeros(1,x);
eulercromervelocity = zeros(1,x);
eulercromeraccleration = zeros(1,x);

eulercromervelocity(1)= 0;
eulercromerposition(1)= yInitial;

for i=2:x+1
    eulercromeraccleration(i) = -(k*position(i-1))/mass;
    eulercromervelocity(i) = (eulercromervelocity(i-1))+(eulercromeraccleration(i-1)*dt);
    eulercromerposition(i) =  (eulercromerposition(i-1))+(eulercromervelocity(i)*dt) ;
end
      figure  %('name','figure 3')
        subplot(2,1,1)
            plot(time,position,time,exactposition,time,eulercromerposition)
            title('Position vs. Time')
            xlabel('Time (s)')
            xlim([0 51])
            ylabel('Position (m)')
            legend({'Euler Position','Exact Position','Euler Cromer Position'},'Location',"eastoutside")
        subplot(2,1,2)    
            plot(time, velocity,time,exactvelocity,time, eulercromervelocity)
            title('Velocity vs. Time')
            xlabel('Time (s)')
            xlim([0 51])
            ylabel('Velocity (m/s)') 
            legend({'Euler Velocity','Exact Velocity','Euler Cromer Velocity'},'Location',"eastoutside")
% Exercise 5: Energy in the Euler-Cromer Algorithm Model of a SHO

eulerenergy = zeros(1,n);

for i=2:n
    eulerenergy(i) = (.5*mass*(eulercromervelocity(i))^2)+(mass*gravity*eulercromerposition(i))+(.5*k*(eulercromerposition(i))^2);
end
figure % figure 4   
        plot(time,eulerenergy)
        title('Energy (Euler-Cromer Method) vs. Time')
        xlabel('Time (s)')
        ylabel('Energy')
        
 clc;