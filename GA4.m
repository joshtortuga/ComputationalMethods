tic
format compact
format long
clc; clear;
close all

dt = 200;
n =20*10^6;
massOfEarth = 5.97*10^24;
massOfMoon = 7.34767309*10^22;
gravity = 6.67*10^-11;
time = zeros(1,n);
time(1) = 0;

%Exercise 1
xPosition = zeros(1,n); %Declaring arrays
yPosition = zeros(1,n);
xVelocity = zeros(1,n);
yVelocity = zeros(1,n);
xAccelration = zeros (1,n);
yAcceleration = zeros (1,n);
magnitudeRadius = zeros(1,n);
magnitudeVelocity = zeros(1,n);
KE = zeros(1,n);
PE = zeros(1,n);
Etot = zeros(1,n);

xPosition(1) = 4.04*10^8; %initial conidtions for arrays
yPosition(1) = 0;
magnitudeRadius(1) = sqrt((xPosition(1))^2+(yPosition(1))^2);
xVelocity(1) = 0;
yVelocity(1) = 964;
magnitudeVelocity(1) = sqrt((xVelocity(1))^2+(yVelocity(1))^2);
xAccelration(1) = (-gravity*massOfEarth*xPosition(1))/(magnitudeRadius(1))^3;
yAcceleration(1) = 0;
KE(1) = 0;
PE(1) = 0;
Etot(1) = PE(1) +KE(1);

for i = 2:n   %for loop to create a time array
    time(i) = (i)*dt;
end

%euler method: first method of calculating position, velocity, and accleration
for i = 2:n 
    xPosition(i) = xPosition(i-1)+xVelocity(i-1)*dt;
    yPosition(i) = yPosition(i-1)+yVelocity(i-1)*dt;
    
    magnitudeRadius(i) = sqrt((xPosition(i))^2+(yPosition(i))^2);
    
    xVelocity(i) = xVelocity(i-1)+xAccelration(i-1)*dt;
    yVelocity(i) = yVelocity(i-1)+yAcceleration(i-1)*dt;
    magnitudeVelocity(i) = sqrt((xVelocity(i))^2+(yVelocity(i))^2);
    
    xAccelration(i) = (-gravity*massOfEarth*xPosition(i))/(magnitudeRadius(i))^3;
    yAcceleration(i) = (-gravity*massOfEarth*yPosition(i))/(magnitudeRadius(i))^3;
    
    KE(i) = .5*massOfMoon*(magnitudeVelocity(i))^2;
    PE(i) = massOfMoon*gravity*(sqrt((xPosition(i))^2)+(yPosition(i)^2));
    
    Etot(i) = KE(i)+PE(i);   
    
end

%euler-cromer method: second method of calculating position, velocity, and accleration
xPositionCromer = zeros(1,n); %declaration of arrays for the euler-cromer method
yPositionCromer = zeros(1,n);
xVelocityCromer = zeros(1,n);
yVelocityCromer = zeros(1,n);
xAccelrationCromer = zeros (1,n);
yAccelerationCromer = zeros (1,n);
magnitudeRadiusCromer = zeros(1,n);
magnitudeVelocityCromer = zeros(1,n);
KECromer = zeros(1,n);
PECromer = zeros(1,n);
EtotCromer = zeros(1,n);

xPositionCromer(1) = 4.04*10^8; %initial conditions for the euler-cromer arrays
yPositionCromer(1) = 0;
magnitudeRadiusCromer(1) = sqrt((xPositionCromer(1))^2+(yPositionCromer(1))^2);
xVelocityCromer(1) = 0;
yVelocityCromer(1) = 964;
magnitudeVelocityCromer(1) = sqrt((xVelocity(1))^2+(yVelocity(1))^2);
xAccelrationCromer(1) = (-gravity*massOfEarth*xPositionCromer(1))/(sqrt((xPositionCromer(1))^2+(yPositionCromer(1))^2)^3);
yAccelerationCromer(1) = 0;
KECromer(1) = 0;
PECromer(1) = 0;
EtotCromer(1) = PECromer(1) +KECromer(1);

for i = 2:n %for loop to calcualte position,velocity, and accleration s
    xVelocityCromer(i) = xVelocityCromer(i-1)+xAccelrationCromer(i-1)*dt;
    yVelocityCromer(i) = yVelocityCromer(i-1)+yAccelerationCromer(i-1)*dt;
    
    magnitudeVelocityCromer(i) = sqrt((xVelocityCromer(i))^2+(yVelocityCromer(i))^2);
    
    xPositionCromer(i) = xPositionCromer(i-1)+xVelocityCromer(i)*dt;
    yPositionCromer(i) = yPositionCromer(i-1)+yVelocityCromer(i)*dt;
    
    magnitudeRadiusCromer(i) = sqrt((xPositionCromer(i))^2+(yPositionCromer(i))^2);
    
    xAccelrationCromer(i) = (-gravity*massOfEarth*xPositionCromer(i))/(sqrt((xPositionCromer(i))^2+(yPositionCromer(i))^2)^3);
    yAccelerationCromer(i) = (-gravity*massOfEarth*yPositionCromer(i))/(sqrt((xPositionCromer(i))^2+(yPositionCromer(i))^2)^3); 
    
    KECromer(i) = .5*massOfMoon*(magnitudeVelocityCromer(i))^2;
    PECromer(i) = massOfMoon*gravity*(sqrt((xPositionCromer(i))^2)+(yPositionCromer(i)^2));
    
    EtotCromer(i) = KECromer(i)+PECromer(i);       
end
min(xPositionCromer)
max(xPositionCromer)

figure('Name','Comparison of the two methods')
plot(xPosition,yPosition,xPositionCromer,yPositionCromer)
title('Euler Moon Orbit vs Euler-Cromer Orbit')
xlabel('X Position (m)')
ylabel('Y Position (m)')
legend({'Euler Method Moon Orbit','Euler-Cromer Moon Orbit'},'Location',"eastoutside")

figure('Name','Euler-Cromer Method')
plot(xPositionCromer,yPositionCromer)
title('Euler-Cromer orbit')
xlabel('X Position (m)')
ylabel('Y Position (m)')

figure('Name','Comparison of Energies')
plot(time,Etot,time,EtotCromer)
title('Total Energy vs. Total Cromer Energy')
xlabel('Time (s)')
xlim([0 3.5*10^6])
ylabel('Energy (m)')
legend({'Euler Method Total Energy','Euler-Cromer Total Energy'},'Location',"eastoutside")

%Exercise 2 Accuracy of Symplectic Algorithms
xPositionLF = zeros(1,n);
yPositionLF = zeros(1,n);
xVelocityLF = zeros(1,n);
yVelocityLF = zeros(1,n);
xAccelrationLF = zeros (1,n);
yAccelrationLF = zeros (1,n);
magnitudeRadiusLF = zeros(1,n);
magnitudeVelocityLF = zeros(1,n);
KELF = zeros(1,n);
PELF = zeros(1,n);
EtotLF = zeros(1,n);

magnitudeRadiusLF(1) = sqrt((xPositionLF(1))^2+(yPositionLF(1))^2);
xPositionLF(1) = 4.04*10^8;
yPositionLF(1) = 0;
xVelocityLF(1) = 0;
yVelocityLF(1) = 964;
magnitudeVelocityLF(1) = sqrt((xVelocityLF(1))^2+(yVelocityLF(1))^2);
xAccelrationLF(1) = (-gravity*massOfEarth*xPositionLF(1))/(sqrt((xPositionLF(1))^2+(yPositionLF(1))^2)^3);
yAccelrationLF(1) = 0;
KELF(1) = 0;
PELF(1) = 0;
EtotLF(1) = PECromer(1) +KECromer(1);


for i= 2:n
    xPositionLF(i) = .5*xAccelrationLF(i-1)*dt^2+xPositionLF(i-1)+ xVelocityLF(i-1)*dt;
    yPositionLF(i) = .5*yAccelrationLF(i-1)*dt^2+yPositionLF(i-1)+ yVelocityLF(i-1)*dt;
    
    magnitudeRadiusLF(i) = sqrt((xPositionLF(i))^2+(yPositionLF(i))^2);
    
    xAccelrationLF(i) = (-gravity*massOfEarth*xPositionLF(i))/((sqrt((xPositionLF(i))^2+(yPositionLF(i))^2)^3));
    yAccelrationLF(i) = (-gravity*massOfEarth*yPositionLF(i))/((sqrt((xPositionLF(i))^2+(yPositionLF(i))^2)^3));
    
    xVelocityLF(i) = .5*(xAccelrationLF(i-1)+xAccelrationLF(i))*dt+xVelocityLF(i-1);
    yVelocityLF(i) = .5*(yAccelrationLF(i-1)+yAccelrationLF(i))*dt+yVelocityLF(i-1);
    
    
    KELF(i) = .5*massOfMoon*(magnitudeVelocityCromer(i))^2;
    PELF(i) = massOfMoon*gravity*(sqrt((xPositionCromer(i))^2)+(yPositionCromer(i)^2));
    
    EtotLF(i) = KELF(i)+PELF(i);  
end

figure('Name','Leap Frong Moon Orbital')
plot(xPositionLF,yPositionLF,xPositionCromer,yPositionCromer)
title('Moon Orbital Leap Frog')
xlabel('X Position (m)')
ylabel('Y Position (m)')

min(xPositionLF)
max(xPositionLF)
% legend({'Leap Frog Position','Leap Frog Position Cromer'},'Location',"eastoutside")

%Exercise 3: Halley's Comet
massofSun = 1.989*10^30;
x = 12000000;

xPositionHC = zeros(1,n);
yPositionHC = zeros(1,n);
xVelocityHC = zeros(1,n);
yVelocityHC = zeros(1,n);
xAccelrationHC = zeros (1,n);
yAccelrationHC = zeros (1,n);
magnitudeRadiusHC = zeros(1,n);
magnitudeVelocityHC = zeros(1,n);
KEHC = zeros(1,n);
PEHC = zeros(1,n);
EtotHC = zeros(1,n);

magnitudeRadiusHC(1) = sqrt((xPositionHC(1))^2+(yPositionHC(1))^2);
xPositionHC(1) = 8.77*10^10;
yPositionHC(1) = 0;
xVelocityHC(1) = 0;
yVelocityHC(1) = 54550;
xAccelrationHC(1) = (-gravity*massofSun*xPositionHC(1))/(sqrt((xPositionHC(1))^2+(yPositionHC(1))^2)^3);
yAccelrationHC(1) = 0;


for i= 2:x
    xPositionHC(i) = .5*xAccelrationHC(i-1)*dt^2+xPositionHC(i-1)+ xVelocityHC(i-1)*dt;
    yPositionHC(i) = .5*yAccelrationHC(i-1)*dt^2+yPositionHC(i-1)+ yVelocityHC(i-1)*dt;
    
    magnitudeRadiusHC(i) = sqrt((xPositionHC(i))^2+(yPositionHC(i))^2);
    
    xAccelrationHC(i) = (-gravity*massofSun*xPositionHC(i))/((sqrt((xPositionHC(i))^2+(yPositionHC(i))^2)^3));
    yAccelrationHC(i) = (-gravity*massofSun*yPositionHC(i))/((sqrt((xPositionHC(i))^2+(yPositionHC(i))^2)^3));
    
    xVelocityHC(i) = .5*(xAccelrationHC(i-1)+xAccelrationHC(i))*dt+xVelocityHC(i-1);
    yVelocityHC(i) = .5*(yAccelrationHC(i-1)+yAccelrationHC(i))*dt+yVelocityHC(i-1);
    
    KEHC(i) = .5*massOfMoon*(magnitudeVelocityHC(i))^2;
    PEHC(i) = massOfMoon*gravity*(sqrt((xPositionHC(i))^2)+(yPositionHC(i)^2));
     
     EtotHC = KEHC(i)+PEHC(i); 
end

figure('Name','Halleys Comet')
plot(xPositionHC,yPositionHC)
title('Leap Frog  Comet Orbital Trajectory')
xlabel('X Position (m)')
ylabel('Y Position (m)')

min(xPositionHC)
max(xPositionHC)

toc


