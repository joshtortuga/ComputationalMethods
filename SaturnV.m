clear; clc;

%Declaring Variables
RadiusOfEarth=6.38*10^6; %radius of the Earth (m)
MassOfEarth=5.98*10^24; %mass of the Earth (kg)
gravity=6.673*10^-11; %gravitational constant (N*m^2/kg^2)

Stage1Thrust=34*10^6; %Thrust of stage 1 (N)
Stage2Thrust=5*10^6; %Thrust of stage 2 (N)
Stage3Thrust=1*10^6; %Thrust of stage 3 (N)

Stage1Velocity=2580; %exhaust velocity of stage 1 (m/s)
Stage2Velocity=4130; %exhaust velocity of stage 2 (m/s)
Stage3Velocity=4130; %exhaust velocity of stage 3 (m/s)

Stage1EmptyMass=131000; %empty mass of stage 1 (kg)
Stage2EmptyMass=36000; %empty mass of stage 2 (kg)
Stage3EmptyMass=11000; %empty mass of stage 3 (kg)

Stage1FueledMass=2300000; %full mass of stage 1 (kg)
Stage2FueledMass=480000; %full mass of stage 2 (kg)
Stage3FueledMass=119000; %full mass of stage 3 (kg)
PayloadMass=52000; %mass of the payload (kg)

dt=.1; %step size
n=10000; %number of iterations
i=2;


time=zeros(1,n); %time array
RocketMass=zeros(1,n); %mass array
yPosition=zeros(1,n); %position array
velocity=zeros(1,n); %velocity array
acceleration=zeros(1,n); %acceleration array

%starting values
time(1)=0; %starting value for time
yPosition(1)=0; %starting value for position
velocity(1)=0; %starting value for velocity
acceleration(1)=-gravity*MassOfEarth/(RadiusOfEarth+yPosition(1))^2; %starting value for acceleration
RocketMass(1)=Stage1FueledMass+Stage2FueledMass+Stage3FueledMass+PayloadMass; %starting value for mass

MRBJ1=Stage1EmptyMass+Stage2FueledMass+Stage3FueledMass+PayloadMass; %mass after stage 1
MRBJ2=Stage2EmptyMass+Stage3FueledMass+PayloadMass; %mass after stage 2
MRBJ3=Stage3EmptyMass+PayloadMass; %mass after stage 3

%loop for stage 1
while (RocketMass(i-1)>MRBJ1) %loop runs until stage one is empty
    time(i)=time(i-1)+dt;
    RocketMass(i)=RocketMass(i-1)-Stage1Thrust*dt/Stage1Velocity;
    yPosition(i)=yPosition(i-1)+velocity(i-1)*dt;
    velocity(i)=velocity(i-1)+acceleration(i-1)*dt;
    acceleration(i)=-gravity*MassOfEarth/(RadiusOfEarth+yPosition(i))^2+Stage1Thrust/RocketMass(i);
    i=i+1; %change in i value to associate change in stage
end

RocketMass(i)=Stage2FueledMass+Stage3FueledMass+PayloadMass; %new mass after empty stage 1
pause1=i+3*(1/dt); %time for waiting after jettision

%for loop for time waiting after jettison
for i=i:pause1 %runs for the time of the pause 
    time(i)=time(i-1)+dt;
    RocketMass(i)=RocketMass(i-1);
    yPosition(i)=yPosition(i-1)+velocity(i-1)*dt;
    velocity(i)=velocity(i-1)+acceleration(i-1)*dt;
    acceleration(i)=-gravity*MassOfEarth/(RadiusOfEarth+yPosition(i))^2; %no thrust in equations due to wait after jettison
    i=i+1;
end

%loop for stage 2
while (RocketMass(i-1)>MRBJ2) %loop runs until stage 2 is empty
    time(i)=time(i-1)+dt;
    RocketMass(i)=RocketMass(i-1)-Stage2Thrust*dt/Stage2Velocity;
    yPosition(i)=yPosition(i-1)+velocity(i-1)*dt;
    velocity(i)=velocity(i-1)+acceleration(i-1)*dt;
    acceleration(i)=-gravity*MassOfEarth/(RadiusOfEarth+yPosition(i))^2+Stage2Thrust/RocketMass(i);
    i=i+1;
end

RocketMass(i)=Stage3FueledMass+PayloadMass; %new mass after stage 2 is empty
pause2=i+3*(1/dt); %same time wait for jettison

%loop for wait after jettison
for i=i:pause2
    time(i)=time(i-1)+dt;
    RocketMass(i)=RocketMass(i-1);
    yPosition(i)=yPosition(i-1)+velocity(i-1)*dt;
    velocity(i)=velocity(i-1)+acceleration(i-1)*dt;
    acceleration(i)=-gravity*MassOfEarth/(RadiusOfEarth+yPosition(i))^2;
    i=i+1;
end

%loop for stage 3
while (RocketMass(i-1)>MRBJ3) %loop runs until stage 3 is empty
    time(i)=time(i-1)+dt;
    RocketMass(i)=RocketMass(i-1)-Stage3Thrust*dt/Stage3Velocity;
    yPosition(i)=yPosition(i-1)+velocity(i-1)*dt;
    velocity(i)=velocity(i-1)+acceleration(i-1)*dt;
    acceleration(i)=-gravity*MassOfEarth/(RadiusOfEarth+yPosition(i))^2+Stage3Thrust/RocketMass(i);
    i=i+1;
end

RocketMass(i)=PayloadMass; %new mass for after all stages empty 

%loop for after all fuel is empty
while (velocity(i-1)>=0) %loop runs until velocity of rocket is 0
    time(i)=time(i-1)+dt;
    RocketMass(i)=RocketMass(i-1)*dt;
    yPosition(i)=yPosition(i-1)+velocity(i-1)*dt;
    velocity(i)=velocity(i-1)+acceleration(i-1)*dt;
    acceleration(i)=-gravity*MassOfEarth/(RadiusOfEarth+yPosition(i))^2;
    i=i+1;
end

%plots for accel, velocity, and position vs time graphs
figure("Name",'reee')
subplot(2,2,1);
plot(time,acceleration)
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
title('Acceleration vs Time');

subplot(2,2,2);
plot(time,velocity)
xlabel('Time (s)');
ylabel('Velocity (m/s)');
title('Velocity vs Time');

subplot(2,2,3);
plot(time,yPosition)
xlabel('Time (s)');
ylabel('Position (m)');
title('Position vs Time');

max(yPosition)


