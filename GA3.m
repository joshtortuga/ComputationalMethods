format compact
format long
clc; clear;
close all

dt=.001; %change of time
n=150000; % number of iterations

k=10; %spring constant 
mass=1; %mass


time=zeros(1,n);  %declaration of arrays
ECposition=zeros(1,n);
ECvelocity=zeros(1,n);
ECacceleration=zeros(1,n);

time(1)=0; %initial conditions for arrays
ECvelocity(1)=0;
ECposition(1)=.1;
ECacceleration(1)=-(k/mass)*ECposition(1);


RKposition = zeros(1,n); %declaration of arrays
RKvelocity = zeros(1,n);
RKacceleration = zeros(1,n);

RKposition(1) = .1; %initial conidtions for arrays
RKvelocity(1) = 0;
RKacceleration(1) = ((-k*RKposition(1))/mass);

halfStepAccleration = zeros(1,n); %declaration of arrays
halfStepVelocity = zeros(1,n);
halfStepPosition = zeros(1,n);

halfStepVelocity(1) = 0; %initial conidtions for arrays
halfStepPosition(1) = 0;
halfStepAccleration(1) = 0;

%Euler Cromer Method
for i=3:n+1 % loop that fills the array values
   time(i-1)=time(i-2)+dt;
   ECvelocity(i-1)=ECvelocity(i-2)+ECacceleration(i-2)*dt;
   ECposition(i-1)=ECposition(i-2)+ECvelocity(i-1)*dt;
   ECacceleration(i-1)=-(k/mass)*ECposition(i-1);
end

%RK Method 
for i=3: n+1 % loop that fills the array values
 
    RKvelocity(i-1) = RKvelocity(i-2)+halfStepAccleration(i-2)*dt;
    RKposition(i-1) = RKposition(i-2)+halfStepVelocity(i-2)*dt;
    RKacceleration(i-1) = (-k*RKposition(i-1)/mass);
     
    halfStepVelocity(i-1) = (RKvelocity(i-1))+RKacceleration(i-1)*dt/2;
    halfStepPosition(i-1) = RKposition(i-1)+RKvelocity(i-1)*dt/2;
    halfStepAccleration(i-1) = (-k*halfStepPosition(i-1))/mass;
    
end

%Actual Method 
exactVelocity = zeros (1,n); %declaration of arrays
exactPosition = zeros (1,n);

exactPosition(1) = RKposition(1); %initial conidtions for arrays
exactVelocity(1) = 0;

for i=3:n+1 % loop that fills the array values
    exactPosition(i-1) = exactPosition(1)*cos((i-2)*sqrt(k/mass)*dt);
    exactVelocity(i-1) = -sqrt((k)/mass)*exactPosition(1)*sin((i-2)*sqrt(k/mass)*dt);
end
figure
subplot(2,1,1)
plot(time,RKposition,time,exactPosition,time,ECposition) %graph of time vs position 
 legend({'RK Position','Exact Position', 'Euler Cromer Position'},'Location',"eastoutside")
 title('Undamped Position vs. Time')
 xlabel('Time (s)')
 xlim([0 26])

 ylabel('Position (m)')
 subplot(2,1,2)    
  plot(time, RKvelocity,time,exactVelocity, time,ECvelocity)
  title('Undamped Velocity vs. Time')
  xlabel('Time (s)')
  xlim([0 26])
  ylabel('Velocity(m/s)') 
  legend({'RK Velocity','Exact Velocity', 'Euler Cromer Velocity'},'Location',"eastoutside")

%Exercise 2

b = .3; %damping constant

RKposition2 = zeros(1,n); %declaration of arrays
RKvelocity2 = zeros(1,n);
RKacceleration2 = zeros(1,n);

RKposition2(1) = .1; %initial conidtions for arrays
RKvelocity2(1) = 0;
RKacceleration2(1) = ((-k*RKposition2(1))/mass)-((RKvelocity2(1)*b/mass));

halfStepAccleration2 = zeros(1,n); %declaration of arrays
halfStepVelocity2 = zeros(1,n);
halfStepPosition2 = zeros(1,n);

halfStepVelocity2(1) = halfStepVelocity(1) ; %initial conidtions for arrays
halfStepPosition2(1) = halfStepPosition(1);
halfStepAccleration2(1) = halfStepAccleration(1);


for i=3: n+1 % loop that fills the array values
    RKvelocity2(i-1) = RKvelocity2(i-2)+halfStepAccleration2(i-2)*dt;
    RKposition2(i-1) = RKposition2(i-2)+halfStepVelocity2(i-2)*dt;
    RKacceleration2(i-1) = (-k*RKposition2(i-1)/mass);
     
    halfStepVelocity2(i-1) = (RKvelocity2(i-1))+RKacceleration2(i-1)*dt/2;
    halfStepPosition2(i-1) = RKposition2(i-1)+halfStepVelocity2(i-1)*dt/2;
    halfStepAccleration2(i-1) = ((-k*halfStepPosition2(i-1))/mass)-((RKvelocity2(i-1)*b/mass));
end
figure
plot(time,RKposition2) %graph of time vs position 
 title('Damped Position vs. Time')
 xlabel('Time (s)')
 ylabel('Position (m)')
 xlim([0 55])

%Exercise 3

force = .2;
omega = 1;

RKposition3 = zeros(1,n); %declaration of arrays
RKvelocity3 = zeros(1,n);
RKacceleration3 = zeros(1,n);

RKposition3(1) = .1; %initial conidtions for arrays
RKvelocity3(1) = 0;
RKacceleration3(1) = ((-k*RKposition3(1))/mass)-((RKvelocity3(1)*b/mass));

halfStepAccleration3 = zeros(1,n); %declaration of arrays
halfStepVelocity3 = zeros(1,n);
halfStepPosition3 = zeros(1,n);

halfStepVelocity3(1) = halfStepVelocity(1) ; %initial conidtions for arrays
halfStepPosition3(1) = halfStepPosition(1);
halfStepAccleration3(1) = halfStepAccleration(1);


for i=3: n+1  % loop that fills the array values
    RKvelocity3(i-1) = RKvelocity3(i-2)+halfStepAccleration3(i-2)*dt;
    RKposition3(i-1) = RKposition3(i-2)+halfStepVelocity3(i-2)*dt;
    RKacceleration3(i-1) = (-k*RKposition3(i-1)/mass);
     
    halfStepVelocity3(i-1) = (RKvelocity3(i-1))+RKacceleration3(i-1)*dt/2;
    halfStepPosition3(i-1) = RKposition3(i-1)+halfStepVelocity3(i-1)*dt/2;
    halfStepAccleration3(i-1) = ((-k*halfStepPosition3(i-1))/mass)-((RKvelocity3(i-1)*b/mass))+(force/mass)*cos(omega*(i-1)*dt);
end

figure
plot(time,RKposition3) %graph of time vs position 
 title('Forced Position vs. Time')
 xlabel('Time (s)')
 ylabel('Position (m)')
 xlim([0 50])